import 'package:flutter/material.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:lojaonline/screens/sigup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 117, 40, 212),
          actions: [
            FlatButton(
              child: Text("CRIAR CONTA",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SingupScreen()));
              },
            )
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
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
                        if (text.isEmpty || !text.contains("@")) {
                          return "E-mail invalido";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 16),
                  TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6) {
                          return "Senha invalida";
                        } else {
                          return null;
                        }
                      }),
                  Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (_emailController.text.isEmpty)
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Insira seu e-mail para recuperação"),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 3)));
                          else {
                            model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Confira seu e-mail"),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 3))
                                );
                          }
                        },
                      )),
                  SizedBox(height: 16),
                  SizedBox(
                      height: 44,
                      child: RaisedButton(
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        color: Color.fromARGB(255, 117, 40, 212),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}
                          model.singIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        },
                      )),
                ],
              ));
        }));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Falha ao entrar."),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3)));
  }
}
