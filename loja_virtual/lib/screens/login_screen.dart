import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _onSuccess() {
      print("teste");
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Usuário logado com sucesso!"),
          duration: Duration(seconds: 2)));

      Navigator.of(context).pop();
    }

    void _onFail() {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Erro ao realizar login."),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2)));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15),
            ),
            textColor: Colors.white,
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: _emailController,
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
                controller: _passController,
                decoration: InputDecoration(hintText: "Senha"),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6) {
                    return "Senha inválida";
                  }
                  return null;
                },
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text("Insira seu e-mail para recuperação."),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2)));
                      } else {
                        model.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu e-mail!."),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2)));
                      }
                    },
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  )),
              SizedBox(height: 16),
              SizedBox(
                height: 44,
                child: RaisedButton(
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: () => _onSuccess(),
                          onFailure: () => _onFail());
                    }
                  },
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}