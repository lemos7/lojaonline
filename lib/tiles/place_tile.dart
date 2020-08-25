import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
       child: Column(
         children: [
           SizedBox(
             height: 150,
             child: Image.network(snapshot.data["image"],
             fit: BoxFit.cover,
             ),
           ),
           Container(
             child: Padding(padding: EdgeInsets.all(8),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text(
                  snapshot.data["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                 ),
                 Text(
                  snapshot.data["address"],
                  textAlign: TextAlign.start,
                 ),
                 
               ],
             ),
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               FlatButton(              
               child: Text("Ver no mapa"),
               textColor: Colors.blue,
               padding: EdgeInsets.zero,
               onPressed: (){
                 launch("https://www.google.com/maps/search/?api=1&query=${snapshot.data["lat"]}, ${snapshot.data["long"]}");
               }, 
               ),
               FlatButton(              
               child: Text("Ligar"),
               textColor: Colors.blue,
               padding: EdgeInsets.zero,
               onPressed: (){
                 launch("tel: ${snapshot.data["fone"]}");
               }, 
               )
             ],
           )
         ],
       ),
      
    );
  }
}