import 'package:flutter/material.dart';
import 'package:buscar_gifs/ui/home_page.dart';

const API_KEY = 'q6CKMdjApTKWY35Eo63GZGfC3mbWqHh8';

void main() {
  runApp(MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          hintColor: Colors.white,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))))));
}
