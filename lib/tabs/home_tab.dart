import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 117, 40, 212),
            Color.fromARGB(255, 23, 9, 41)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    //Usando Stack, tudo o que colocar por ultimo
    //ficará por cima dosoutros
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Página inicial"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                //pegando da coleção *home* ordenando pelo parametro *pos*
                future: Firestore.instance
                    .collection("home")
                    .orderBy("pos")
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  //determinando a largura da grade com o .count
                  else
                    //a imagem é x de largura e y de altura
                    return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      staggeredTiles: snapshot.data.documents.map((doc) {
                        return StaggeredTile.count(
                            doc.data["x"], doc.data["y"]);
                      }).toList(),
                      children: snapshot.data.documents.map(
                        (doc){
                          return FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: doc.data["image"],
                          fit: BoxFit.cover,);
                        }
                      ).toList()
                    );
                })
          ],
        ),
      ],
    );
  }
}
