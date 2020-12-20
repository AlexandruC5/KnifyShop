import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:KnifyShop/knife.dart';
import 'package:flutter/rendering.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  Widget _buildMainPage(List<Knife> docs) {
    final knifes = FirebaseFirestore.instance.collection('Knifes');
    return Scaffold(
      appBar: AppBar(
        title: Text("Knifes we have right now."),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final knife = docs[index];
                    return ListTile(
                        title: Text(
                      knife.name,
                    ));
                  }))
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: knifeListSnapshots(),
      builder: (context, AsyncSnapshot<List<Knife>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(snapshot.error);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildLoading();
          case ConnectionState.active:
            return _buildMainPage(snapshot.data);
          default:
            _buildError('Unreachable');
        }
      },
    );
  }
}
