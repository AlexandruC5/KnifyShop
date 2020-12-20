import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';

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
      home: MainPage(),
    );
  }
}

///Testing doc upload to Firestore
Future upload() async {
  final refUser = FirebaseFirestore.instance.collection("user").doc();
  await refUser.set({"username": "Alex"});
}
