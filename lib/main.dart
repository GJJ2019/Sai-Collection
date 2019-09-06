import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

//
import 'package:flutter/material.dart';

//
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
import 'package:sai_collection/splash_screen.dart';
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Home/home_page.dart';
import 'package:sai_collection/UI/Login/login.dart';
import 'package:sai_collection/UI/start_screen.dart';

Future<void> main() async {
  SharedP.sharedPreferences = await SharedPreferences.getInstance();
  SharedP.firestore = Firestore();
  SharedP.cloudFunctions = CloudFunctions();
  SharedP.scaffoldState = GlobalKey<ScaffoldState>();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    // set app version Number
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // SharedPreferencesModel sharedPreferencesModel = SharedPreferencesModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sai Collection',
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Colors.deepOrange,
        primaryColorLight: Colors.black.withOpacity(0.6),
        accentColor: Colors.black,
        cursorColor: Colors.black,
        buttonTheme: ButtonThemeData(
          splashColor: Colors.white,
          buttonColor: Colors.deepOrange,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
        ),
        cardTheme: CardTheme(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 10.0,
        ),
        accentIconTheme: IconThemeData(color: Colors.amber),
        fontFamily: "Gotham Light",
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => Login(),
        '/start screen': (context) => StartScreen(),
        '/home': (context) => HomePage(),
        // '/list product' : (context) => ListProducts(_productName)
      },
      // home: SuccessfulScreen(),
      // home: SplashScreen(),
      // home: MyApp1(),
      // home: Account(),
      // home: Payment(),
      // home: HomePage(),
      // home: MyApp1(),
      // home: AboutUs(),
      // home: ContactUs(),
      // home: Login(),
      // home: Offline(),
      // home: StartScreen(),
      // home: MyOrders(),
      // home: ListProducts('T-shirt'),
      // ),
    );
  }
}

// class MyApp1 extends StatefulWidget {
//   const MyApp1({Key key}) : super(key: key);

//   @override
//   _MyApp1State createState() => _MyApp1State();
// }

// class _MyApp1State extends State<MyApp1> {
//   final _functions = CloudFunctions.instance;
//   List result;

//   @override
//   void initState() {
//     super.initState();
//     //   fetch();
//     // }

//     // fetch() async {
//     _functions.getHttpsCallable(functionName: 'getUpiId').call({}).then((v) {
//       print('Results are ${v.data}');
//       result = v.data;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBarCreate().appbarCreate(context, 'Shimmer'),
//         body: result == null
//             ? CircularProgressIndicator()
//             : ListView.builder(
//                 itemCount: result.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(
//                     children: <Widget>[
//                       Text(
//                         result[index]['token'],
//                         style: TextStyle(fontSize: 30.0),
//                       ),
//                       Text(
//                         result[index]['hey'],
//                         style: TextStyle(fontSize: 30.0),
//                       ),
//                     ],
//                   );
//                 },
//               ));
//   }
// }

// //  Container(
// //           height: 400.0,
// //           width: 200.0,
// //           margin: const EdgeInsets.all(10.0),
// //           // child: Text('data'),
// //           // color: Colors.black,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(20.0),
// //             color: Color.fromRGBO(00, 00, 00, 0.1)
// //           ),
// //           // decoration: Bo,
// //         ),
// //       ),
