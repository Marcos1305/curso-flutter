import 'package:chat_online/chat_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

// keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(iconTheme: IconThemeData(color: Colors.blue)),
        home: ChatScreen());
  }
}
