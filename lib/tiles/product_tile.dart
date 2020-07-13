import 'package:flutter/material.dart';
import 'package:lojaonline/datas/product_data.dart';
import 'package:lojaonline/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    //inkwell para dar uma animação para o usuario
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductScreen(product))
        );
      },
      child: Card(
        //se o tipo for ma grid
        child: type == "grid"
            ?
            //retorna uma coluna
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //AspectRatio é para definir o tamanho da imagem independente
                  //do aparelho
                  AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            :
            //senão uma linha
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "R\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
