import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: ElevatedButton(
                child: Text('See our recomended knifes!'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/two');
                },
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom:20.0),
            child: ElevatedButton(
                child: Text('Make a Request!'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/three');
                }),
          ),
          ElevatedButton(
            child: Text('See current requests'),
            onPressed:(){
              Navigator.of(context).pushNamed('/four');
            }
          )
        ])
        );
  }
}
