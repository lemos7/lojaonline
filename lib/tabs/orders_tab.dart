import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:lojaonline/screens/login_screen.dart';
import 'package:lojaonline/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("users").document(uid)
      .collection("orders").getDocuments(),
      builder: (context, snapshot){

        if(!snapshot.hasData){
           return Center(
             child: CircularProgressIndicator()
           );
        }else{
          return ListView(
            children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList()
            .reversed.toList()
          );
        }
      }
      );

    }else{
      return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.view_list,
              size: 80, color: Theme.of(context).primaryColor),
          SizedBox(height: 16),
          Text(
            "Faça o login para acompanhar !",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          RaisedButton(
            child: Text(
              "Entrar",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            color: Color.fromARGB(255, 117, 40, 212),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
    );
    }
  }
}