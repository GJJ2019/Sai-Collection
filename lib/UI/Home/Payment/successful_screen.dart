import 'package:flutter/material.dart';
//
import 'package:flare_flutter/flare_actor.dart' show FlareActor;

class SuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   '😄',
            //   style: TextStyle(
            //     fontSize: 50.0,
            //   ),
            // ),
            Container(
              height: 200.0,
              // color: Colors.black,
              child: FlareActor(
                'assets/Animation/Success Check.flr',
                animation: 'done',
                isPaused: false,
                fit: BoxFit.contain,
              ),
            ),
            // SizedBox(
            //   height: 30.0,
            // ),
            Text(
              '🤗 Thank You For Ordering 🤗',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              child: new Text(
                'Continue Shopping',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                ),
              ),
              // padding: const EdgeInsets.symmetric(
              //     horizontal: 40.0, vertical: 15.0),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                // ShowDialog().showAlertDialog(context, 'Loading');
              },
              // shape: new RoundedRectangleBorder(
              //   borderRadius: new BorderRadius.circular(30.0),
              // ),
              // color: Theme.of(context).accentColor,
              // splashColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Note: \n\n  - Your Product Will Be Deliver Within 24 Hours.\n\n  - Please Give Us Feedback.\n\n  - Report A Bug If Found',
            ),
          ],
        ),
      ),
    );
  }
}
