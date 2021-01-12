import 'package:flutter/material.dart';



class HomePage extends StatelessWidget{

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:AppBar(
        title:Text("Home Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Center(
          child:ElevatedButton(
            child: Text('See our recomended knifes!'),
            onPressed: (){
              Navigator.of(context).pushNamed('/two');
            },
          ),
          ),
        ),
    );
  }
}