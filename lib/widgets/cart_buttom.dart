import 'package:flutter/material.dart';
import 'package:lojaonline/screens/cart_screen.dart';

class CartButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white),
      backgroundColor: Color.fromARGB(255, 117, 40, 212),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartScreen()));
      },
    );
  }
}