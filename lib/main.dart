import 'package:flutter/material.dart';
import 'package:loginapp/view/login_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent.shade100,
      ),
      home: LoginPage(),
    );
  }
}
