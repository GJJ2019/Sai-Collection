import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
//
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
//
import 'package:sai_collection/page_transition.dart';
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/About/about_us.dart';
import 'package:sai_collection/UI/About/contact_us.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';
import 'package:sai_collection/UI/Home/Account/account.dart';
import 'package:sai_collection/UI/Home/Order/order_history.dart';
import 'package:sai_collection/UI/Update/check_for_update.dart';

class DrawerHome {
  Widget drawer(
    BuildContext context,
    String mobileNumber,
  ) {
    // FirebaseAuth _auth = FirebaseAuth.instance;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            // gradient: new LinearGradient(
            //     colors: [
            //       // Theme.of(context).accentColor,
            //       Theme.of(context).accentColor,
            //       Colors.white
            //     ],
            //     begin: const FractionalOffset(0.5, 0.0),
            //     end: const FractionalOffset(0.0, 0.4),
            //     stops: [0.0, 1.0],
            //     tileMode: TileMode.mirror),
            ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              // child: Text(
              //   'Hello, \n\n  $mobileNumber ',
              //   style: TextStyle(
              //     fontSize: 24.0,
              //     color: Theme.of(context).primaryColor,
              //   ),
              // ),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'Hello, \n\n',
                    style: TextStyle(
                        fontSize: 36.0,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 1.0),
                  ),
                  TextSpan(
                    text: '     $mobileNumber 😉',
                    // text: '     1234567890 😉',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ]),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    CupertinoIcons.home,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Home',
                    // style: TextStyle(fontSize: 16.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // Navigator.pushReplacement(
                    //     context, MaterialPageRoute(builder: (context) => Home()));
                  },
                ),

                // ListTile(
                //   leading: Icon(
                //     CupertinoIcons.shopping_cart,
                //     color: Theme.of(context).accentColor,
                //   ),
                //   title: Text(
                //     'My Cart',
                //   ),
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     ShowSnackBar().showSnackBar(context, _scaffoldState,
                //         'This Feature Is Under Development');
                //   },
                // ),

                // ListTile(
                //   leading: Icon(
                //     CupertinoIcons.heart,
                //     color: Theme.of(context).accentColor,
                //   ),
                //   title: Text(
                //     'My Wishlist',
                //   ),
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     ShowSnackBar().showSnackBar(context, _scaffoldState,
                //         'This Feature Is Under Development');
                //   },
                // ),

                ListTile(
                  leading: Icon(
                    CupertinoIcons.shopping_cart,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'My Order',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            builder: (context) => MyOrders(mobileNumber)));
                  },
                ),

                ListTile(
                  leading: Icon(
                    CupertinoIcons.profile_circled,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'My Account',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        builder: (context) => Account(),
                      ),
                    );
                    // ShowSnackBar().showSnackBar(context, _scaffoldState, 'This Feature Is Under Development');
                  },
                ),

                ListTile(
                  leading: Icon(
                    CupertinoIcons.phone,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Contact Us',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          builder: (context) => ContactUs(),
                        ));
                  },
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.time,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Check For Update',
                  ),
                  onTap: () {
                    Navigator.of(context).push(PageTransition(
                      builder: (context) => CheckForUpdate(),
                    ));
                    // Firestore.instance
                    //     .collection('Admin')
                    //     .document('version')
                    //     .get()
                    //     .then((data) async {
                    //   print('Version is ${data['version']}');
                    // });
                  },
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.info,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'About Us',
                  ),
                  onTap: () {
                    // ShowSnackBar().showSnackBar(context, _scaffoldState, 'This Feature Is Under Development');

                    Navigator.of(context).push(PageTransition(
                      builder: (context) => AboutUs(),
                    ));
                  },
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.share_up,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Share Us  😃',
                  ),
                  onTap: () async {
                    // ShowSnackBar().showSnackBar(context, _scaffoldState, 'This Feature Is Under Development');
                    void _showMessage() {
                      Navigator.of(context).pop();
                      ShowSnackBar().showSnackBar(context,
                          'What\'s App Not Install', SharedP.scaffoldState);
                    }

                    SharedP.firestore
                        .collection('Admin')
                        .document('app')
                        .get()
                        .then((data) async {
                      print('App Links are ${data['app-link']}');
                      String appLink = data['app-link'];
                      String whatsAppUrl =
                          "whatsapp://send?text=Download App To Get Best Products In Wardha $appLink";
                      // "whatsapp://send?text=Download The Best Products in Wardha With Great Deals & Offers ${data['app-link']}";
                      await canLaunch(whatsAppUrl)
                          ? launch(whatsAppUrl).then((v) {
                              print("Values are $v");
                              // }).catchError((error) {
                              //   print("Errors are $error");
                              // }).whenComplete(() {
                              //   print("When Complete called");
                            })
                          : _showMessage();
                    });
                  },
                ),

                // ListTile(
                //   leading: Icon(
                //     Icons.power_settings_new,
                //     color: Theme.of(context).accentColor,
                //   ),
                //   title: Text(
                //     "Log Out",

                //   ),
                //   onTap: () {
                //     if (_auth.currentUser() != null) {
                //       _auth.signOut();
                //     }
                //     Navigator.pushReplacement(context,
                //         MaterialPageRoute(builder: (context) => Login()));
                //   },
                // ),

                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  color: Theme.of(context).accentColor,
                  height: 1.0,
                ),
                Center(
                    child: Text(
                  'Created By GJJ2019',
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                )),
                SizedBox(
                  height: 7.0,
                ),
                Center(
                  child: Text(
                    '\u00A9 Copyright By Grass',
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //       horizontal: 30.0, vertical: 10.0),
                //   color: Theme.of(context).accentColor,
                //   height: 1.0,
                // ),
                SizedBox(
                  height: 10.0,
                ),
                // FlatButton(
                //   // textColor: Theme.of(context).accentColor,
                //   onPressed: () {},
                //   child: Text(
                //     '\u20B9Donate Me\u20B9',
                //     style: TextStyle(
                //       color: Theme.of(context).primaryColor,
                //       // letterSpacing: 1.2
                //       // fontSize: 20.0
                //     ),
                //   ),
                //   color: Theme.of(context).primaryColorDark,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(35.0),
                //   ),
                //   splashColor: Theme.of(context).primaryColor,
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
