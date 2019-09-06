import 'dart:async';
// 
import 'package:flutter/material.dart';
// 
import 'package:connectivity/connectivity.dart' show Connectivity, ConnectivityResult;
import 'package:flare_flutter/flare_actor.dart' show FlareActor;
//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/offline.dart';

class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
  // SharedPreferences _prefs;
  // @override
  // void initState() {
  //   super.initState();
  //   _setSharedPreferencesValues();
  // }

  // @override
  // void initState() {
  //   // SharedPreferencesModel().creationOfSharedPrefs();
  //   super.initState();
  // }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SharedPreferences prefs;

  // @override
  // void initState() {
  //   super.initState();
  //   createSharedPreferences();
  // }

  // createSharedPreferences() async {
  //   // prefs = await SharedPreferences.getInstance();
  //   // _setSharedPreferencesValues();
  //   // print('called $prefs');
  //   // bool login = true;
  //   String mobileNumber = SharedP.sharedPreferences.getString('Mobile Number');
  //   if (mobileNumber == null) {
  //     // login = false;
  //     // } else {
  //     // login = true;
  //     Timer(Duration(seconds: 5),
  //         () => Navigator.pushReplacementNamed(context, '/start screen'));
  //     // Navigator.pushReplacementNamed(context, '/start screen');
  //   } else {
  //     Timer(Duration(seconds: 5),
  //         () => Navigator.pushReplacementNamed(context, '/home'));
  //     // Navigator.pushReplacementNamed(context, '/home');
  //   }
  // }

  // void _setSharedPreferencesValues() {
  //   // _prefs = await SharedPreferences.getInstance();
  //   print('called $prefs');
  //   // bool login = true;
  //   String mobileNumber = prefs.getString('Mobile Number');
  //   if (mobileNumber == null) {
  //     // login = false;
  //     // } else {
  //     // login = true;
  //     // Timer(Duration(seconds: 4),
  //     // () => Navigator.pushReplacementNamed(context, '/start screen'));
  //     Navigator.pushReplacementNamed(context, '/start screen');
  //   } else {
  //     // Timer(Duration(seconds: 4),
  //     // () => Navigator.pushReplacementNamed(context, '/home'));
  //     Navigator.pushReplacementNamed(context, '/home');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return ScopedModelDescendant<SharedPreferencesModel>(
    //   builder: (context, child, model) {
    //     model.creationOfSharedPrefs();
    //     // _prefs = model.prefs;
    //     _setSharedPreferencesValues(context, model.prefs);

    // prefs = ;
    // _setSharedPreferencesValues();
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // return OfflineBuilder(
    //   child: SizedBox(),
    //   connectivityBuilder: (BuildContext context,
    //       ConnectivityResult connectivityResult, Widget w) {
    //     bool connection = !(connectivityResult == ConnectivityResult.none);
    //     if (connection) {
    //       createSharedPreferences();
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (BuildContext context,
          AsyncSnapshot<ConnectivityResult> connectivityResult) {
        print(
            'Mobile Number is ${SharedP.sharedPreferences.getString('Mobile Number')}');
        if (connectivityResult.connectionState == ConnectionState.done) {
          bool connection =
              !(connectivityResult.data == ConnectivityResult.none);
          if (connection) {
            String mobileNumber =
                SharedP.sharedPreferences.getString('Mobile Number');
            if (mobileNumber == null) {
              // login = false;
              // } else {
              // login = true;
              Timer(
                  Duration(seconds: 5),
                  () =>
                      Navigator.pushReplacementNamed(context, '/start screen'));
              // Navigator.pushReplacementNamed(context, '/start screen');
            } else {
              Timer(Duration(seconds: 5),
                  () => Navigator.pushReplacementNamed(context, '/home'));
              // Navigator.pushReplacementNamed(context, '/home');
            }
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColorDark,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      child: FlareActor(
                        'assets/Animation/Sai Collections logo.flr',
                        animation: 'rotate',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Sai Collection',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: CircularProgressIndicator(
                        // backgroundColor: Colors.blueAccent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // return Offline();
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColorDark,
              body: Offline().offline(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {});
                },
                child: Icon(Icons.refresh),
                backgroundColor: Theme.of(context).primaryColor,
                mini: true,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // } else {
    //   // return Center(
    //   //   child: Text(
    //   //     'No Internet Connection 😥',
    //   //     style: TextStyle(
    //   //       fontSize: 20.0,
    //   //       color: Theme.of(context).primaryColor,
    //   //       fontWeight: FontWeight.bold,
    //   //       letterSpacing: 1.2,
    //   //     ),
    //   //   ),
    //   // );
    //   return Offline();
    // }
    // return connection
    //     ? Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Text(
    //               'Sai Collection',
    //               style: TextStyle(
    //                 fontSize: 30.0,
    //                 color: Theme.of(context).primaryColor,
    //                 fontWeight: FontWeight.bold,
    //                 letterSpacing: 1.2,
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(top: 20.0),
    //               child: CircularProgressIndicator(
    //                 // backgroundColor: Colors.blueAccent,
    //                 valueColor: AlwaysStoppedAnimation<Color>(
    //                     Theme.of(context).primaryColor),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     : SizedBox();
    //   },
    // );
    // );
    //   },
    // );
  }
}

//  ! Junk code --------

// Timer(Duration(seconds: 4), () {
// Navigator.
// Navigator.pushReplacement(context, login ? '/home' : '/start screen');
// Navigator.pushReplacementNamed(
// context, login ? '/home' : '/start screen');
// });

// if (mobileNumber == null) {
// Timer(Duration(seconds: 4),
// () => Navigator.of(context).pushReplacementNamed('/start screen'));
// } else {
// Timer(Duration(seconds: 4),
// () => Navigator.of(context).pushReplacementNamed('/home'));
// }
// bool t;
// try {
//   t = _prefs.getBool('login');
// } catch (e) {
//   t = false;
// }
// print('login $t');
// if (t == null) {
// t = false;
// }
// try {
//   t = prefs.getBool('login');
//   print(t);
// } on NoSuchMethodError catch (e) {
//   print(e);
//   t = false;
// }
// if ( != null) {
// t = true;
// } else {
// t = false;
// }

// new Timer(
//   Duration(seconds: 4),
//   () => Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => login ? HomePage() : StartScreen(),
//         ),
//       ),
// );
