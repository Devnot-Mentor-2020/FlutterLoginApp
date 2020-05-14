import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log in"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width*(8/9),
            child: Text("Welcome Back",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width*(8/9),
            child: Text("Sign in to continue",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}
