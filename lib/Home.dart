import 'package:flutter/material.dart';



class HomePage extends StatelessWidget{

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:AppBar(
        title:Text("Home Page"),
      ),
      body: Center(
        child: RaisedButton(
          child:Text('Recomended knifes'),
          onPressed: (){
            Navigator.of(context).pushNamed('/two');
          },
        ),
      ),
    );
  }
}