import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline/datas/cart_produt.dart';
import 'package:lojaonline/datas/product_data.dart';
import 'package:lojaonline/models/cart_model.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:lojaonline/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    const colPurple = 0xFF7528d4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 117, 40, 212),
        title: Text(product.title),
        centerTitle: true,

      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              //transformando as imagens em uma lista de urls
              images: product.images.map((url){
              return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor:  Color.fromARGB(255, 117, 40, 212),
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(product.title, style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                ),
                  maxLines: 3,
                ),
                Text("R\$ ${product.price.toStringAsFixed(3)}",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 117, 40, 212),
                ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: (){
                      if(UserModel.of(context).isLoggedIn()){

                        CartProduct cartProduct = CartProduct();
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;

                        CartModel.of(context).addCartItem(cartProduct);
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                          );
                      }
                    },
                  child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao carrinho" : "Entre para comprar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  color: Color.fromARGB(255, 117, 40, 212),
                  ),
                ),
                SizedBox(height: 16),
                Text("Descrição: ", style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(product.description)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

