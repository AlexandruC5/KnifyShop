import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Request.dart';

class RequestKnifePage extends StatefulWidget {
  _RequestKnifePage createState() => _RequestKnifePage();
}

class _RequestKnifePage extends State<RequestKnifePage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(error) {
    return Scaffold(
      body: Center(
        child: Text(
          error.toString(),
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void addRequest(String text) async {
    await FirebaseFirestore.instance
        .collection('Requests')
        .doc()
        .set({'Name': text});
  }

  Widget _buildRequestKnifePage(List<Request> docs) {
    var textField = TextField(
      decoration: InputDecoration(
          filled: true,
          labelText:
              'Introduce the name and price range of the knife you want'),
      onSubmitted: (String knifeName) {
        addRequest(knifeName);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Request a knife we dont have'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Make a request of the knife you want! Add the name and a price range ex: Deba 150-200€',
                  style: TextStyle(
                    fontSize: 20,
                      fontFamily: 'Ariel',
                      backgroundColor: Colors.amber[200]
                      ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/knife.png')
                    ),
                ),
              ),
              textField,
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: requestedKnifeSnapshots(),
      builder: (context, AsyncSnapshot<List<Request>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(snapshot.error);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildLoading();
          case ConnectionState.active:
            return _buildRequestKnifePage(snapshot.data);
          default:
            _buildError('Unreachable');
        }
      },
    );
  }
}
