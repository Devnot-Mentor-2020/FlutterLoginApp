import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email,_password;
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryColor: Colors.redAccent.shade100
        ),
        child: Scaffold(
          appBar: AppBar(title: Text("Log In Page",style: TextStyle(color: Colors.white),),),

          body: Builder(
              builder:(context)=>
              Form(
              key: formKey,
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*(8/9),
                    child: Text("Welcome Back",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width*(8/9),
                    child: Text("Sign in to continue",style: TextStyle(fontSize: 20,color: Colors.grey),),
                  ),

                  SizedBox(height: 10,),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter your username",
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateEmail,
                      onSaved: (input) => _email=input,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter your password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: _passwordValidate,
                      onSaved: (input) => _password=input,
                    ),
                  ),

                  Align(
                    alignment:Alignment.centerRight,
                    child: InkWell(
                      onTap: () => debugPrint('Forgot clicked'),
                      child: new Container(
                        width: MediaQuery.of(context).size.width*(1/2),
                        height: 50,
                        child: new Center(child: new Text('Forgot Password', style: new TextStyle(fontSize: 18.0, color: Colors.black),),),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: ()=> _saveGivenInformation(context),
                    child: new Container(
                      width: MediaQuery.of(context).size.width*(8/9),
                      height: 50,
                      decoration: new BoxDecoration(
                        color: Colors.redAccent.shade100,
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Center(child: new Text('Log In', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  String _validateEmail(String input) {
     if(!input.contains("@")){
      return "Please enter correct email";
    }
    else{
      return null;
    }
  }

  String _passwordValidate(String input) {
    if(input.length<5){
      return "Please enter longer than 5 characters";
    }
    else{
      return null;
    }
  }

  void _saveGivenInformation(BuildContext context) {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      debugPrint("asdasd = " + _email +" bosuk" + _password);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Email: " + _email +"\nPassword: " + _password),
      ));
    }
  }
}
