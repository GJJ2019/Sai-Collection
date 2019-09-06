import 'package:flutter/material.dart';
//
import 'package:flare_flutter/flare_actor.dart';
//
import 'package:sai_collection/UI/Home/Account/account.dart';
import 'package:sai_collection/page_transition.dart';

class ShowDialog {
  // showAlertDialog(BuildContext context, String title, String feeling) {
  showAlertDialog(BuildContext context, String title) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Image.asset(
              //   'assets/images/emoji.png',
              //   fit: BoxFit.fill,
              // ),
              // Container(
              //   height: 200.0,
              //   // decoration: BoxDecoration(
              //   //   borderRadius: BorderRadius.vertical(
              //   //     top: Radius.circular(25.0),
              //   //   ),
              //   //   image: DecorationImage(
              //   //     image: AssetImage('assets/images/$feeling.png'),
              //   //     fit: BoxFit.fill,
              //   //   ),
              //   // ),
              //   child: FlareActor(filename),
              // ),
              Container(
                height: 200.0,
                // color: Colors.black,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.vertical(
                //     top: Radius.circular(25.0),
                //   ),
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                  child: FlareActor(
                    'assets/Animation/Mountain.flr',
                    animation: 'rotate',
                    isPaused: false,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                '\n$title...\n',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Please Don\'t Press Back Button\n',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 15.0,
                ),
              ),
              Container(
                height: 40.0,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        );
      },
    );
  }

  showAccountCompletionDialog(BuildContext context) {
    // String _smsCode;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
            // contentPadding: EdgeInsets.only(top: 10.0),
            title: Text(
              'Complete Your Profile 🙄 By Adding Name & Address',
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
              textAlign: TextAlign.start,
            ),
            //   textAlign: TextAlign.center,
            // ),,
            content: Container(
              // width: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Account()));
                      Navigator.of(context).push(
                        PageTransition(
                          builder: (context) => Account(),
                        ),
                      );
                    },
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 30.0, vertical: 15.0),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                    //   ),
                    // ),
                    // color: Theme.of(context).accentColor,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20.0)
                    // )
                    // splashColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
