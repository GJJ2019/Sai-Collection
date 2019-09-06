import 'package:flutter/material.dart';
//
import 'package:sai_collection/page_transition.dart';
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Login/login.dart';
import 'package:sai_collection/UI/Components/generate_random.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';

class StartScreen extends StatelessWidget {
//   @override
//   _StartScreenState createState() => _StartScreenState();
// }
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

// class _StartScreenState extends State<StartScreen> {
//   // SharedPreferences prefs;
  // final _cloudFirestore = Firestore();

  // List<String> quality = [
  //   'Best \n Quality',
  //   'Best \n Price',
  //   'Best \n Discount',
  //   'Best \n Guarantee',
  //   'Zero \n Transaction\n Charges',
  //   'One \n Day\n Home\n Delivery',
  // ];
  // List imageUrl = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getSpecification();
  // }

  // List<String> termsCondition = [
  //   '- We definitely ensure your privacy.',
  //   '- Cancel of Order is not available.',
  //   '- Defected products will be replace.',
  //   '- If you have any Issues contact us.'
  // ];

  // List<String> features = [
  //   'Best Quality :',
  //   'Best Price :',
  //   'Zero Transaction Charges :',
  //   'Free Shipping :',
  //   'One Day Home Delivery :',
  //   'Get Cashbacks :',
  //   'Terms & Condition :'
  // ];

  List<String> features = [
    'Best Quality :',
    'Best Price :',
    'Zero Transaction Charges :',
    'Free Shipping :',
    'One Day Home Delivery :',
    'Best Customer Services :',
    'Get Cashbacks :',
    'Terms & Condition :',
  ];
  List details = [
    'This app gives you direct access to best products in Wardha District & We ensure the QUALITY of our products.',
    'Get the best quality product at lowest price with great % DISCOUNT % deals.',
    'As all payments are UPI base you will have zero transaction charge.',
    'Free Home delivery on every order.',
    'We guarantee One Day Home Delivery on every order.',
    'Get solution or action on each and every report/complaint.',
    'Get exciting cashbacks on Orders.',
    [
      '- We definitely ensure your privacy.',
      '- Cancel of Order is not available.',
      '- Defected products will be replace.',
      '- If you have any Issues contact us.',
    ],
  ];

  // Map a = {};
  // Map a = {
  //   'Best Quality :':
  //       'This app gives you direct access to best products in Wardha District & We ensure the QUALITY of our products',
  //   'Best Price :':
  //       'Get the best quality product at lowest price with great % DISCOUNT % deals',
  //   'Zero Transaction Charges :':
  //       'As all payments are UPI base you will have zero transaction charge',
  //   'Free Shipping :': 'Free Home delivery on every order',
  //   'One Day Home Delivery :':
  //       'We guarantee One Day Home Delivery on every order',
  //   'Best Customer Services :':
  //       'Get solution or action on each and every report/complaint',
  //   'Get Cashbacks :': 'Get exciting cashbacks on Orders',
  //   'Terms & Condition :': [
  //     '- We definitely ensure your privacy',
  //     '- Cancel of Order is not available',
  //     '- Defected products will be replace',
  //     '- If you have any Issues contact us',
  //   ],
  // };

  // @override
  // void initState() {
  //   super.initState();
  //   a.forEach((key, values) {
  //     features.add(key);
  //     details.add(values);
  //   });
  //   // print(a.keys);
  // }

  // getSpecification() async {
  //   _cloudFirestore.collection('Offers').document('Offers').get().then((v) {
  //     quality = v['Specifications'];
  //     quality = List<String>.from(quality);
  //     // imageUrl = v['Images'];
  //     // imageUrl = List<String>.from(imageUrl);
  //     print('quality Called $quality');
  //     // print('quality Called $imageUrl');
  //   });
  // }

  // List<String> image = [
  //   'assets/images/t_shirt.jpg',
  //   'assets/images/lowers.png',
  //   'assets/images/formal_shirts.png',
  //   'assets/images/jeans.jpg',
  //   'assets/images/t_shirt.jpg',
  //   'assets/images/formal_shirts.png',
  // ];

  List<Widget> getListFeaturesAndDetails() {
    List<Widget> a = [];
    for (int i = 0; i < features.length; i++) {
      a.add(SizedBox(
        height: 20.0,
      ));
      a.add(
        Text(
          features[i],
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      a.add(
        SizedBox(
          height: 10.0,
        ),
      );
      if (features[i] == 'Terms & Condition :') {
        // for (var index = 0; index < details[i].length; index++) {
        for (String detail in details[i]) {
          // print('details are -$detail');
          a.add(
            SizedBox(
              height: 1.0,
            ),
          );
          a.add(
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '$detail',
                style: TextStyle(fontSize: 16.0),
                strutStyle: StrutStyle(height: 1.2),
              ),
            ),
          );
        }
      } else {
        a.add(
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '${details[i]}',
              style: TextStyle(fontSize: 16.0),
              strutStyle: StrutStyle(height: 1.2),
            ),
          ),
        );
      }
    }
    a.add(
      SizedBox(
        height: 30.0,
      ),
    );
    return a;
  }

  @override
  Widget build(BuildContext context) {
    // print(a..forEach((k, v) {
    //   print('Keys are $k');
    //   print('Values are $v');
    // }));
    // print('Features are $features');
    // print('Details are $details');
    // print(a.keys);
    // return OfflineBuilder(
    //   child: SizedBox(),
    //   connectivityBuilder: (BuildContext context,
    //       ConnectivityResult connectivityResult, Widget w) {
    //     bool connection = !(connectivityResult == ConnectivityResult.none);
    //     if (connection) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorDark,
      key: _scaffoldState,
      body:
          // OfflineBuilder(
          //     child: SizedBox(),
          //     connectivityBuilder: (BuildContext context,
          //         ConnectivityResult connectivity, Widget child) {
          //       final bool connected = connectivity != ConnectivityResult.none;
          //       // print('Called builder');
          //       return connected
          // ?
          SingleChildScrollView(
        // padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getListFeaturesAndDetails(),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: RaisedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   PageTransition(
          //     child: Login(),
          //     type: PageTransitionType.rightToLeftWithFade,
          //     duration: Duration(milliseconds: 500),
          //   ),
          // );
          SharedP.sharedPreferences.setInt('version', 1);
          print(
              'Version Number is ${SharedP.sharedPreferences.getInt('version')}');
          String verifiedRandomNumber =
              GenerateRandom().generateRandomNumber(5);
          String nonVerifiedRandomNumber =
              GenerateRandom().generateRandomNumber(5);
          _settingModalBottomSheet(
              context, verifiedRandomNumber, nonVerifiedRandomNumber);
          // prefs = await SharedPreferences.getInstance();
          // if (_startScreenBloc.connection.internet) {
          // new Timer(Duration(seconds: 3), () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => Login()));
          // });
          // } else {
          //   print('snackbar');
          //   ShowSnackBar().showSnackBar(
          //       context, _scaffoldState, 'NO INTERNET CONNECTION');
          // }
        },
        // padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.0,
            letterSpacing: 1.5,
            fontFamily: 'Gotham Light',
          ),
        ),
        color: Theme.of(context).primaryColorDark,
        // splashColor: Theme.of(context).primaryColor,
        // shape:
        // RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
    //     } else {
    //       return Offline();
    //     }
    //   },
    // );
  }

  void _settingModalBottomSheet(
      context, verifiedRandomNumber, nonVerifiedRandomNumber) {
    List<Widget> items =
        getListButtons(verifiedRandomNumber, nonVerifiedRandomNumber, context);
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        builder: (BuildContext buildContext) {
          return Container(
            height: 200.0,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Container(
                //   width: 50.0,
                //   margin: EdgeInsets.only(bottom: 20.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20.0),
                //     border: Border.all(
                //       color: Colors.black.withOpacity(0.2),
                //       width: 5.0,
                //     ),
                //   ),
                // ),
                Text(
                  'I\'m Human 🙂:',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColorDark
                  ),
                ),
                Text(
                  '$verifiedRandomNumber',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // ListView(
                //   scrollDirection: Axis.horizontal,
                //   children: getListButtons(randomNumber),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: items,
                )
              ],
            ),
          );
        });
  }

  List<Widget> getListButtons(
      verifiedRandomNumber, nonVerifiedRandomNumber, context) {
    List<Widget> items = [
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            PageTransition(
              builder: (context) => Login(),
            ),
          );
        },
        child: Text(
          verifiedRandomNumber,
          style:
              TextStyle(fontSize: 15.0, color: Theme.of(context).primaryColor),
        ),
        splashColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColorDark,
        // borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
      ),
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          ShowSnackBar()
              .showSnackBar(context, 'You Are Not Human 😓', _scaffoldState);
        },
        child: Text(
          nonVerifiedRandomNumber,
          style:
              TextStyle(fontSize: 15.0, color: Theme.of(context).primaryColor),
        ),
        splashColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColorDark,
      ),
    ];
    items.shuffle();
    return items;
  }
}

// ! Junk Code -----------------------------------------------------------

// floatingActionButton:
//     RaisedButton(
//   onPressed: () async {
//     // Navigator.push(
//     //   context,
//     //   PageTransition(
//     //     child: Login(),
//     //     type: PageTransitionType.rightToLeftWithFade,
//     //     duration: Duration(milliseconds: 500),
//     //   ),
//     // );
//     String verifiedRandomNumber = randomNumeric(5);
//     String nonVerifiedRandomNumber = randomNumeric(5);
//     _settingModalBottomSheet(
//         context, verifiedRandomNumber, nonVerifiedRandomNumber);
//     // prefs = await SharedPreferences.getInstance();
//     // if (_startScreenBloc.connection.internet) {
//     // new Timer(Duration(seconds: 3), () {
//     //   Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //           builder: (context) => Login()));
//     // });
//     // } else {
//     //   print('snackbar');
//     //   ShowSnackBar().showSnackBar(
//     //       context, _scaffoldState, 'NO INTERNET CONNECTION');
//     // }
//   },
//   padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
//   child: Text(
//     'Sign In',
//     style: TextStyle(
//         color: Theme.of(context).primaryColor,
//         fontSize: 18.0,
//         letterSpacing: 1.5,
//         fontFamily: 'Gotham Light'),
//   ),
// ),
// persistentFooterButtons: <Widget>[
//   RaisedButton(
//     onPressed: () async {
//       // Navigator.push(
//       //   context,
//       //   PageTransition(
//       //     child: Login(),
//       //     type: PageTransitionType.rightToLeftWithFade,
//       //     duration: Duration(milliseconds: 500),
//       //   ),
//       // );
//       String verifiedRandomNumber = randomNumeric(5);
//       String nonVerifiedRandomNumber = randomNumeric(5);
//       _settingModalBottomSheet(
//           context, verifiedRandomNumber, nonVerifiedRandomNumber);
//       // prefs = await SharedPreferences.getInstance();
//       // if (_startScreenBloc.connection.internet) {
//       // new Timer(Duration(seconds: 3), () {
//       //   Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //           builder: (context) => Login()));
//       // });
//       // } else {
//       //   print('snackbar');
//       //   ShowSnackBar().showSnackBar(
//       //       context, _scaffoldState, 'NO INTERNET CONNECTION');
//       // }
//     },
//     padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
//     child: Text(
//       'Sign In',
//       style: TextStyle(
//         color: Theme.of(context).primaryColor,
//         fontSize: 18.0,
//         letterSpacing: 1.5,
//         fontFamily: 'Gotham Light',
//       ),
//     ),
//     color: Theme.of(context).primaryColorDark,
//     splashColor: Theme.of(context).primaryColor,
//     shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//   ),
// ],
// bottomNavigationBar:
// ,
//       : Center(
//           child: Text(
//             'No Internet Connection 😴',
//             style: TextStyle(
//                 color: Theme.of(context).accentColor, fontSize: 20.0),
//           ),
//         );
// }),

// a.add(
//   SizedBox(
//     height: 1.0,
//   ),
// );
// a.add(
//   Padding(
//     padding: const EdgeInsets.only(left: 20.0),
//     child: Text(
//       '${details[i][index]}.',
//       style: TextStyle(fontSize: 16.0),
//       strutStyle: StrutStyle(height: 1.2),
//     ),
//   ),
// );
// }
// for (var detail in details[i]) {
//   a.add(
//     SizedBox(
//       height: 1.0,
//     ),
//   );
//   a.add(
//     Padding(
//       padding: const EdgeInsets.only(left: 20.0),
//       child: Text(
//         '$detail.',
//         style: TextStyle(fontSize: 16.0),
//         strutStyle: StrutStyle(height: 1.2),
//       ),
//     ),
//   );
// }

// children: <Widget>[
// SizedBox(
//   height: 20.0,
// ),
// for (int i = 0; i < details.length; i++)
// Text(
//   'Best Quality :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// }
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'This app gives you direct access to best products in Wardha District & We ensure the QUALITY of our products.',
//   style: TextStyle(fontSize: 16.0),
//   strutStyle: StrutStyle(height: 1.2),
// ),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'Best Price :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'Get the best quality product at lowest price with great % DISCOUNT % deals.',
//   style: TextStyle(fontSize: 16.0),
//   strutStyle: StrutStyle(height: 1.2),
// ),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'Zero Transaction Charges :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'As all payments are UPI base you will have zero transaction charge.',
//   style: TextStyle(fontSize: 16.0),
//   strutStyle: StrutStyle(height: 1.2),
// ),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'Free Shipping :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'Free Home delivery on every order.',
//   style: TextStyle(fontSize: 16.0),
//   strutStyle: StrutStyle(height: 1.2),
// ),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'One Day Home Delivery :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'We guarantee One Day Home Delivery on every order.',
//   style: TextStyle(fontSize: 16.0),
//   strutStyle: StrutStyle(height: 1.2),
// ),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'Get Cashbacks :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'Get exciting cashbacks on Orders.',
//   style: TextStyle(fontSize: 16.0),
//   strutStyle: StrutStyle(height: 1.2),
// ),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'Terms & Condition :',
//   style: TextStyle(
//     fontSize: 24.0,
//     fontWeight: FontWeight.w600,
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 20.0),
//   child: Text(
//     '- We definitely ensure your privacy',
//     style: TextStyle(fontSize: 16.0),
//     strutStyle: StrutStyle(height: 1.2),
//   ),
// ),
// SizedBox(
//   height: 1.0,
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 20.0),
//   child: Text(
//     '- Cancel of Order is not available',
//     style: TextStyle(fontSize: 16.0),
//     strutStyle: StrutStyle(height: 1.2),
//   ),
// ),
// SizedBox(
//   height: 1.0,
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 20.0),
//   child: Text(
//     '- Defected products will be replace.',
//     style: TextStyle(fontSize: 16.0),
//     strutStyle: StrutStyle(height: 1.2),
//   ),
// ),
// SizedBox(
//   height: 1.0,
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 20.0),
//   child: Text(
//     '- If you have any Issues contact us.',
//     // '- If you have any Issues about app feel free to contact us.',
//     style: TextStyle(fontSize: 16.0),
//     strutStyle: StrutStyle(height: 1.2),
//   ),
// ),
// ],
