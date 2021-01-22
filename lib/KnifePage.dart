import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'knife.dart';

class KnifePage extends StatefulWidget {
  DocumentSnapshot doc;
  KnifePage({@required this.doc});
  _KnifePageState createState() => _KnifePageState();

}

class _KnifePageState extends State<KnifePage> {
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

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return image;
  }

  

  Widget _buildKnifePage(List<Knife> docs) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doc.data()['Name']),
      ),
      body: Column(
        children: [
          
          
          
              
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
            return _buildKnifePage(snapshot.data);
          default:
            _buildError('Unreachable');
        }
      },
    );
  }
}

