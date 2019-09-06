import 'package:flutter/material.dart';

class ShowSnackBar {
  // GlobalKey<ScaffoldState> _scaffoldState = SharedP.scaffoldState;
  showSnackBar(BuildContext context, 
      String message, GlobalKey<ScaffoldState> scaffoldState) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'Gotham Light'),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    ));
  }
}
