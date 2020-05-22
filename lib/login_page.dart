import 'package:flutter/material.dart';
import 'core/string_extensions.dart';
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
          
          key: _scaffoldkey,
          appBar: AppBar(title: Text("Log In Page",style: TextStyle(color: Colors.white),),),
          body: SingleChildScrollView(child: loginForm(context)),
          );
  }

  Form loginForm(BuildContext context) {
    return Form(
            key: formKey,
            autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                welcomeContainer(context),
                signinContainer(context),
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                usernameTextField(),
                passwordTextField(),
                forgotPasswordButton(context),
                loginButton(context),
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
                    child: Center(child: Text('Log In', style: TextStyle(fontSize: 18.0, color: Colors.white),),),
                  ),
                );
  }

  Align forgotPasswordButton(BuildContext context) {
    return Align(
                  alignment:Alignment.centerRight,
                  child: InkWell(
                    onTap: () => debugPrint('Forgot clicked'),
                    child: Container(
                      width: MediaQuery.of(context).size.width*(1/2),
                      height: 50,
                      child: Center(child: Text('Forgot Password', style:  TextStyle(fontSize: 18.0, color: Colors.black),),),
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

  void _saveGivenInformation(BuildContext context) {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      debugPrint("asdasd = " + _email +" bosuk" + _password);
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent.shade100,
        content: Text("Email: $_email\nPassword: $_password"),
      ));
    }
  }
}
