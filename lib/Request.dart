import 'package:cloud_firestore/cloud_firestore.dart';

class Request{
  String id;
  String name;
  String description;
  DocumentSnapshot doc;

  Request.fromFirestore(DocumentSnapshot doc)
  {
    this.id = doc.id;
    this.name = doc['Name'];
    //this.description = doc['Description'];
    //this.doc = doc;
    
  }

  
}


Stream<List<Request>> requestedKnifeSnapshots()
{
  final requests = FirebaseFirestore.instance.collection('Requests');
  return requests.snapshots().map((QuerySnapshot query)
  {
    List<Request> result = [];
    for (var doc in query.docs)
    {
      result.add(Request.fromFirestore(doc));
    }
    return result;
  });
}







