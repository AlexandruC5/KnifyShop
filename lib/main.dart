import 'package:KnifyShop/Home.dart';
import 'package:KnifyShop/RequestKnife.dart';
import 'package:KnifyShop/RequestedKnifes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';
import 'Home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //InitFirebase
  await Firebase.initializeApp();
  runApp(KnifyShop());
}

class KnifyShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KnifyShop',
      routes: {
        '/':(context)=>HomePage(),
        '/two':(context)=>MainPage(),
        '/three':(context)=>RequestKnifePage(),
        '/four':(context)=>RequestedKnifesPage(),
      },
      initialRoute: '/',
    );
  }
}

///Testing doc upload to Firestore
Future upload() async {
  final refUser = FirebaseFirestore.instance.collection("user").doc();
  await refUser.set({"username": "Alex"});
}
