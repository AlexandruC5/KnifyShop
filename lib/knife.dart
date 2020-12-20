import 'package:cloud_firestore/cloud_firestore.dart';


class Knife{
  String id;
  String name;
  String price;

  Knife.fromFirestore(DocumentSnapshot doc)
  {
    this.id = doc.id;
    this.name = doc['Name'];
    this.price = doc['Price'];
  }

  
}

Stream<List<Knife>> knifeListSnapshots()
{
  final knifes = FirebaseFirestore.instance.collection('Knifes');
  return knifes.snapshots().map((QuerySnapshot query)
  {
    List<Knife> result = [];
    for (var doc in query.docs)
    {
      result.add(Knife.fromFirestore(doc));
    }
    return result;
  });
}