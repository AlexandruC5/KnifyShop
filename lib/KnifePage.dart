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
    var bottomText = Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(widget.doc.data()["Description"]),
      ),
      decoration: ShapeDecoration(
          color: Colors.red[50],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ))),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doc.data()['Name']),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
            child: FutureBuilder(
              future: _getImage(context, widget.doc.data()['Image']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: snapshot.data,
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
        bottomText,
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(widget.doc.data()["Price"]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text("Buy!"),
            color: Colors.red[500],
            onPressed: null,
          ),
        )
      ]),
      backgroundColor: Colors.orange[100],
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
