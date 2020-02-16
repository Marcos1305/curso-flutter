import 'package:animacoes_complexas/screens/home/home_screen.dart';
import 'package:animacoes_complexas/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animações',
      home: LoginScreen(),
    );
  }
}
