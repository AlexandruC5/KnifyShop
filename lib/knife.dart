import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Knife{
  String id;
  String name;
  String price;
  String description;

  Knife.fromFirestore(DocumentSnapshot doc)
  {
    this.id = doc.id;
    this.name = doc['Name'];
    this.price = doc['Price'];
    this.description = doc['Description'];
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

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}


