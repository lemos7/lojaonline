import 'package:flutter/material.dart';
import 'package:lojaonline/tabs/home_tab.dart';
import 'package:lojaonline/tabs/products_tab.dart';
import 'package:lojaonline/widgets/cart_buttom.dart';
import 'package:lojaonline/widgets/custom_drawer.dart';


class HomeScreen extends StatelessWidget {

  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButtom(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 117, 40, 212),
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButtom(),
        ),
      ],
    );
  }
}
