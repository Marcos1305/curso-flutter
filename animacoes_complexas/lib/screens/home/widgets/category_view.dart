import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final List<String> _categories = ['Trabalho', 'Estudos', 'Casa'];

  int _category = 0;

  void selectForward() {
    setState(() {
      _category++;
    });
  }

  void selectBackward() {
    setState(() {
      _category--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            onPressed: _category > 0 ? selectBackward : null,
            disabledColor: Colors.white30,
            color: Colors.white,
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        Text(
          _categories[_category].toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 18,
              letterSpacing: 1.2),
        ),
        IconButton(
            onPressed:
                _category < _categories.length - 1 ? selectForward : null,
            disabledColor: Colors.white30,
            color: Colors.white,
            icon: Icon(
              Icons.arrow_forward_ios,
            )),
      ],
    );
  }
}
