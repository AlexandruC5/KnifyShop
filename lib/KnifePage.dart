import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'knife.dart';

class KnifePage extends StatelessWidget {
      final knifes = FirebaseFirestore.instance.collection('Knifes');
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Knife'),
        ),
        body: Column(
          children: <Widget>[
            Container(
            
          
            )   
          ],
        ),
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return image;
  }
}
