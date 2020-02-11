import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              "Entrar",
              style: TextStyle(fontSize: 15),
            ),
            textColor: Colors.white,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome Completo"),
              validator: (text) {
                if (text.isEmpty) {
                  return "Nome inválido";
                }

                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || !text.contains('@')) {
                  return "E-mail inválido";
                }

                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6) {
                  return "Senha inválida";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço"),
              validator: (text) {
                if (text.isEmpty) {
                  return "Endereço inválido";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: RaisedButton(
                child: Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
