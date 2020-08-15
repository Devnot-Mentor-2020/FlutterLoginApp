import 'dart:core';
import 'package:flutter/material.dart';
import 'package:loginapp/core/services/google_signin.dart';
import 'file:///C:/Users/Alperen/IdeaProjects/loginapp/lib/core/services/firebase_authentication.dart';
import 'file:///C:/Users/Alperen/IdeaProjects/loginapp/lib/view/course_view/course_operations_homeview.dart';
import 'package:loginapp/view/signup_page.dart';
import '../core/constants/string_extensions.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email,_password;
  final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () async{
            await GoogleSignHelper.instance.signOut();
            },
          heroTag: "btn1",
          ),
          key: _scaffoldkey,
          appBar: AppBar(title: Text("Login Page",style: TextStyle(color: Colors.white),),),
          body: SingleChildScrollView(
              child: loginForm(context),
          ),
          );
  }

  Form loginForm(BuildContext context) {
    return Form(
            key: formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                welcomeContainer(context),
                signinContainer(context),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                usernameTextField(),
                passwordTextField(),
                signUpNavigatorButton(context),
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    loginButton(context),
                    FloatingActionButton.extended(
                      heroTag: "btn2",
                      backgroundColor: Colors.green,
                      onPressed: ()
                      async{
                        var data = GoogleSignHelper.instance.signIn();
                        if(data != null){
                          var userData = await GoogleSignHelper.instance.handleSignIn();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => CourseHomePage()));
                          //print("accesstoken " + userData.accessToken);
                          //print("idToken " + userData.idToken);
                        }
                      },
                      icon: Icon(Icons.outlined_flag),
                      label: Text("Google Login"),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  InkWell loginButton(BuildContext context) {
    return InkWell(
                  onTap: ()=> _saveGivenInformation(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width*(8/9),
                    height: MediaQuery.of(context).size.height*(1/12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade100,
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: Text("Log in ", style: TextStyle(fontSize: 18.0, color: Colors.white),),),
                  ),
                );
  }

  Align signUpNavigatorButton(BuildContext context) {
    return Align(
                  alignment:Alignment.centerRight,
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      width: MediaQuery.of(context).size.width*(1/2),
                      height: 50,
                      child: Center(child: Text('Sign Up', style:  TextStyle(fontSize: 18.0, color: Colors.black),),),
                    ),
                  ),
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

  Container signinContainer(BuildContext context) {
    return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width*(8/9),
                  child: Text("Sign in to continue",style: TextStyle(fontSize: 20,color: Colors.grey),),
                );
  }

  Container welcomeContainer(BuildContext context) {
    return Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width*(8/9),
                  child: Text("Welcome Back",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                );
  }

  Future<void> _saveGivenInformation(BuildContext context) async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        await FirebaseAuthentication.instance.signIn(_email,_password);
        print("information saved");
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseHomePage()));
      }
      catch(e){
        print(e.message);
      }
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent.shade100,
        content: Text("Email: $_email\nPassword: $_password"),
      ));
    }
  }
}

