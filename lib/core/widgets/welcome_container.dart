import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width*(8/9),
      child: Text("Welcome Back",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
    );
  }
}

class SignContainer extends StatelessWidget {
  final String text;

  const SignContainer({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width*(8/9),
        child: Text(text,style: TextStyle(fontSize: 20,color: Colors.grey),),
      );
    }
}

