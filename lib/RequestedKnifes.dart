import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Request.dart';

class RequestedKnifesPage extends StatefulWidget {
  _RequestedKnifesPage createState() => _RequestedKnifesPage();
}

class _RequestedKnifesPage extends State<RequestedKnifesPage> {
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

  Widget _buildRequestedKnifesPage(List<Request> docs) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Current Requests'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final request = docs[index];
                    return ListTile(
                      tileColor: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      title: Text(request.name),
                    );
                  }),
            )
          ],
        ));
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
            return _buildRequestedKnifesPage(snapshot.data);
          default:
            _buildError('Unreachable');
        }
      },
    );
  }
}
