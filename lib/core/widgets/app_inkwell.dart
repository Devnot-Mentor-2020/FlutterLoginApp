import 'package:flutter/material.dart';

class AppInkwell extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTapMethod;

  const AppInkwell({Key key, this.buttonText, this.onTapMethod}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapMethod,
      child: Container(
        width: MediaQuery.of(context).size.width*(8/9),
        height: MediaQuery.of(context).size.height*(1/12),
        decoration: BoxDecoration(
          color: Colors.redAccent.shade100,
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(child: Text(buttonText, style: TextStyle(fontSize: 18.0, color: Colors.white),),),
        ),
    );
  }
}
