import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojaonline/datas/cart_produt.dart';
import 'package:lojaonline/datas/product_data.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  CartModel(this.user){
    if(user.isLoggedIn())
    _loadCartItens();
  }

  String cupomCode;
  int discoutPercentage = 0;

  static CartModel of(BuildContext context) =>
  ScopedModel.of<CartModel>(context);

  bool isLoading = false;

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCarItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }


  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

   void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;
     Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItens() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
    .getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();

  }

  void setCupom(String cupomCode, int discountPercentage){
    this.cupomCode = cupomCode;
    this.discoutPercentage = discoutPercentage;
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null)
      price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * discoutPercentage/100;
    
  }

  double getShipPrice(){
    return 15;
  }

  void updatePrice(){
    notifyListeners();
  }

}
