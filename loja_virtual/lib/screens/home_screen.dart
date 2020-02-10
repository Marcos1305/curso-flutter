import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/cutstom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(this._pageController),
          body: HomeTab(),
        ),
        Container(color: Colors.red),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}