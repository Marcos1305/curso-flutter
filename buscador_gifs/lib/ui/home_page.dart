import 'package:buscar_gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=q6CKMdjApTKWY35Eo63GZGfC3mbWqHh8&limit=25&rating=G");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=q6CKMdjApTKWY35Eo63GZGfC3mbWqHh8&limit=19&offset=$_offset&rating=G&lang=en&q=${_search.trim()}");
    }

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pequise Aqui!",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text.isNotEmpty ? text : null;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError) return Container();

                        return _createGifTable(context, snapshot);
                    }
                  }))
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) return data.length;

    return data.length + 1;
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data["data"].length) {
            var gif = snapshot.data["data"][index];
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: gif["images"]["fixed_height"]["url"],
                fit: BoxFit.cover,
                height: 300,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GifPage(gif);
                }));
              },
              onLongPress: () {
                Share.share(gif["images"]["fixed_height"]["url"]);
              },
            );
          }

          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70),
                  Text("Carregar mais...",
                      style: TextStyle(color: Colors.white, fontSize: 22))
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 19;
                });
              },
            ),
          );
        });
  }
}
