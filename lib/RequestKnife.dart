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

  Widget _buildRequestKnifePage(List<Request> docs)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request a knife we dont have'),
      ),
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
