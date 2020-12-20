import 'package:cloud_firestore/cloud_firestore.dart';


class Knife{
  String id;
  String name;
  String price;
  String description;
  String image;

  Knife.fromFirestore(DocumentSnapshot doc)
  {
    this.id = doc.id;
    this.name = doc['Name'];
    this.price = doc['Price'];
    this.description = doc['Description'];
    this.image = doc['Image'];
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



