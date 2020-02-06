import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

void main() {
  return runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoController = TextEditingController();

  List _todoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _todoList = jsonDecode(data);
      });
    });
  }

  void _addTodo() {
    Map<String, dynamic> newTodo = Map();
    newTodo['title'] = _todoController.text;
    newTodo['ok'] = false;
    _todoController.text = "";
    setState(() {
      _todoList.add(newTodo);
      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _todoList.sort((a, b) {
        if (a['ok'] && !b['ok']) {
          return 1;
        } else if (!a['ok'] && b['ok']) {
          return -1;
        }

        return 0;
      });

      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Add"),
                  textColor: Colors.white,
                  onPressed: () {
                    _addTodo();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _todoList.length,
                itemBuilder: buildItem,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Widget buildItem(context, index) {
    var todo = _todoList[index];
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(todo['title']),
        value: todo['ok'],
        secondary:
            CircleAvatar(child: Icon(todo['ok'] ? Icons.check : Icons.error)),
        onChanged: (value) {
          setState(() {
            todo['ok'] = value;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        _lastRemoved = Map.from(_todoList[index]);
        _lastRemovedPos = index;

        setState(() {
          _todoList.removeAt(index);
        });

        _saveData();

        final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved['title']}\" removida!"),
            action: SnackBarAction(
              label: 'Defazer',
              onPressed: () {
                setState(() {
                  _todoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 2));

        Scaffold.of(context).showSnackBar(snack);
      },
    );
  }
}
