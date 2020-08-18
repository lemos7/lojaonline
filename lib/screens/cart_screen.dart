import 'package:flutter/material.dart';
import 'package:lojaonline/models/cart_model.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:lojaonline/screens/login_screen.dart';
import 'package:lojaonline/tiles/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.products.length;
              return Text(
                "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                style: TextStyle(fontSize: 17),
              );
            }),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn()) {
          return Center(
            child: CircularProgressIndicator(),
          );

          //Caso o usuário não estiver logado
        } else if (!UserModel.of(context).isLoggedIn()) {
          return scrrenNotLogged(context); //Constroi a tela

          //Caso estiver logado mas sem produtos no carrinho
        } else if (model.products == null || model.products.length == 0) {
          return Center(
            child: Text(
              "Nenhum produto no carrinho",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }
        else{
          return productsList(context);
        }
      }),
    );
  }

  Widget productsList(BuildContext context){
    return ScopedModelDescendant<CartModel>(
      builder: (context,child, model){
        return  ListView(
      children: [
        Column(
          children:
           model.products.map(
             (product){
               return CartTile(product);
             }
           ).toList(),
          
        )
      ],
    );
      }
      );
   
  }


  //Tela para caso não estiver logado
  Widget scrrenNotLogged(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_shopping_cart,
              size: 80, color: Theme.of(context).primaryColor),
          SizedBox(height: 16),
          Text(
            "Faça o login para adicionar produtor",
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
