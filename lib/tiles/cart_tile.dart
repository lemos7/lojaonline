import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline/datas/cart_produt.dart';
import 'package:lojaonline/datas/product_data.dart';
import 'package:lojaonline/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    CartModel.of(context).updatePrice();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("products").document(cartProduct.category)
          .collection("itens").document(cartProduct.pid).get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
              return _buildContent(context);
            } else{
              return Container(
                height: 70,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
           ):
           _buildContent(context)
    );
  }

  Widget _buildContent(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
        width: 120,
        child: Image.network(cartProduct.productData.images[0],
        fit: BoxFit.cover)
        ),
        Expanded(
          child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cartProduct.productData.title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),),

              Text("R\ ${cartProduct.productData.price.toStringAsFixed(2)}", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColor)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  IconButton(
                  icon: Icon(Icons.remove), 
                  color: Theme.of(context).primaryColor,
                  onPressed: cartProduct.quantity > 1 ? 
                  (){
                    CartModel.of(context).decProduct(cartProduct);
                  } : null
                   
                  ),
                  Text(cartProduct.quantity.toString()),

                  IconButton(
                  icon: Icon(Icons.add),
                  color: Theme.of(context).primaryColor, 
                  onPressed: (){
                     CartModel.of(context).incProduct(cartProduct);
                  }
                  ),

                  FlatButton(
                     child: Text("Remover"),
                     textColor: Colors.grey[500],
                    onPressed: (){
                      CartModel.of(context).removeCarItem(cartProduct);
                    },
                    )
                ],
              )
            ],
          ),
        ),
        )
      ],
    );
  }
}