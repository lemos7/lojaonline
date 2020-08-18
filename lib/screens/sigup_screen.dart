import 'package:flutter/material.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SingupScreen extends StatefulWidget {

  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 117, 40, 212),
        actions: [
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
          return Center(child: CircularProgressIndicator(),);
          
        return Form(
        key: _formKey,
          child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Nome Completo"),
            validator: (text){
              if(text.isEmpty){
                return "Nome Inválido";
              } else {
                return null;
              }
            }
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: "E-mail"),
            keyboardType: TextInputType.emailAddress,
            validator: (text){
              if(text.isEmpty || !text.contains("@")){
                return "E-mail invalido";
              } else {
                return null;
              }
            }
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passController,
            decoration: InputDecoration(hintText: "Senha"),
            obscureText: true,
            validator: (text){
              if(text.isEmpty || text.length < 6){
                return "Senha invalida";
              } else {
                return null;
              }
            }
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(hintText: "Endereço"),
            validator: (text){
              if(text.isEmpty){
                return "Endereço Inválido";
              } else {
                return null;
              }
            }
          ),
          SizedBox(height: 16),
          SizedBox(height: 44,
          child:RaisedButton(
            child: Text("Criar Conta",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            color: Color.fromARGB(255, 117, 40, 212),
             onPressed: () {
               if(_formKey.currentState.validate()){
                 Map<String, dynamic>userData ={
                   "name": _nameController.text,
                   "email": _emailController.text,
                   "address": _addressController.text,
                 };

                model.singUp(
                  userData: userData, 
                  pass: _passController.text, 
                  onSuccess: _onSuccess, 
                  onFail: _onFail
                  );
               }
             },
          )
          ),
        ],
      )
      );
        }
        )
    );
  }

  //Caso o cadastro ocorrer corretamente
  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso"), 
      backgroundColor: Color.fromARGB(255, 117, 40, 212),
      duration: Duration(seconds: 3)
      )
      ); 
      Future.delayed(Duration(seconds: 3)).then((_){
        Navigator.of(context).pop();
      });
  }
  //caso der algum erro no cadastro
  void _onFail(){
      _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Falha ao criar usuário"), 
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3)
      )
      ); 
      Future.delayed(Duration(seconds: 3)).then((_){
        
      });
  }
}