import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:loginapp/core/widgets/app_inkwell.dart';
import 'package:loginapp/core/widgets/welcome_container.dart';
import 'file:///C:/Users/Alperen/IdeaProjects/loginapp/lib/core/services/firebase_authentication.dart';
import '../core/constants/string_extensions.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email,_password;
  final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: Text("Sign Up Page",style: TextStyle(color: Colors.white),),),
      body: SingleChildScrollView(
          child: loginForm(context)),
    );
  }

  Form loginForm(BuildContext context) {
    return Form(
      key: formKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          WelcomeContainer(),
          SignContainer(text: "Sign up to continue",),
          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
          usernameTextField(),
          passwordTextField(),
          signUpButton(context),
        ],
      ),
    );
  }

  AppInkwell signUpButton(BuildContext context) {
    return AppInkwell(
      buttonText: "Sign Up Now",
      onTapMethod: () => _saveSignUpInformation(context),
    );
  }

  Padding passwordTextField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: "Enter your password",
          labelText: "Password",
          border: OutlineInputBorder(),
        ),
        validator: (value) => value.isValidPassword,
        onSaved: (input) => _password=input,
      ),
    );
  }

  Padding usernameTextField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Enter your username",
          labelText: "Username",
          border: OutlineInputBorder(),
        ),
        validator:(value) => value.isValidEmail,
        onSaved: (input) => _email=input,
      ),
    );
  }

  Future<void> _saveSignUpInformation(BuildContext context) async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      try{
        await FirebaseAuthentication.instance.signUp(_email,_password);
        print("information saved");
        Navigator.pop(context);
      }
      catch(e){
        print(e.message);
      }
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent.shade100,
        content: Text("Succesful operation"),
      ));
      Timer(Duration(seconds: 3),()=>Navigator.pop(context));
    }
  }
}

