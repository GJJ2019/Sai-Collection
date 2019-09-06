// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;
//
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/shared_p.dart';


class AboutUs extends StatelessWidget {
  // String _mailTo = 'gjj2019@yahoo.com';
  // final _firestore = Firestore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCreate().appbarCreate(context, 'About Us'),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'This App is maintain & own by Grass 🙂 along with product provider Sai Collection 😃 itself. All Copyright of this app are reserved. This app is developed by GJJ2019 😃 using Google\'s cross-platform SDK flutter. If You have Any Problem With The Product Or App Kindly Contact Us We Will Definitely Resolve All Your Issues.',
              style: TextStyle(
                  fontSize: 18.0, height: 1.5, fontWeight: FontWeight.w500),
              // textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Terms & Condition :",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "- We definitely ensure your privacy.\n- Cancel of Order is not available.\n- Defected products will be replace.\n- If you have any Issues contact us.",
              style: TextStyle(fontSize: 18.0, height: 1.5),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Want To Make App For Your Own Business / Start-Ups With Zero Cost (Terms & Condition Applied) Kindly Contact Me . I\'m Always Greatful To Help 😄.',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Color.fromRGBO(41, 214, 40, 1.0)),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                //   print("""
                //   Subject : ${_subject.text}
                //   Description : ${_description.text}
                // """);
                // if (_subject.text.isEmpty || _description.text.isEmpty) {
                //   ShowSnackBar().showSnackBar(
                //       context, _scaffoldState, 'Please Enter Proper Data');
                // } else {
                SharedP.firestore
                    .collection('Admin')
                    .document('website-link')
                    .get()
                    .then((data) async {
                  String link = data['link'];
                  print('link is $link');
                  await canLaunch(link) ? launch(link) : print('Cannot launch');
                });
              },
              child: Text(
                'Contact Developer'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  letterSpacing: 1.2,
                ),
              ),
              // padding: EdgeInsets.symmetric(
              // horizontal: 20.0,
              // ),
              // color: Theme.of(context).primaryColorDark,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(35.0),
              // ),
              // splashColor: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
