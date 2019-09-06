import 'dart:async';
//
import 'package:flutter/services.dart' show PlatformException, TextInputType;
import 'package:flutter/material.dart';
//
import 'package:flare_flutter/flare_actor.dart' show FlareActor;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
import 'package:sai_collection/page_transition.dart';
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Home/home_page.dart';
import 'package:sai_collection/UI/Components/show_dialog.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // SharedPreferences _prefs;

  // final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final FirebaseMessaging _messaging = FirebaseMessaging();
  // GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  // bool loading = false;

  // LoginBloc _loginBloc = LoginBloc();

  String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   createSharedPreferences();
  // }

  // createSharedPreferences() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }

  /// Sends the code to the specified phone number.
  Future<void> _sendCodeToPhoneNumber(String phoneNumber) async {
    print("Phone Number is" + phoneNumber);
    final PhoneVerificationCompleted verificationCompleted = (user) {
      setState(() {
        print(
            'Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $user');
        // onVerificationSuccess();
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        Navigator.of(context).pop();
        ShowSnackBar().showSnackBar(
            context, 'Wrong Verification Code 😓', SharedP.scaffoldState);
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + _phoneNumberController.text);
      // ShowSnackBar().showSnackBar(context, 'Code Sent', SharedP.scaffoldState);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
      // ShowSnackBar().showSnackBar(context, 'Time Out', SharedP.scaffoldState);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 1),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void onVerificationSuccess() {
    // loading = true;
    // prefs.setBool('login', true);
    Navigator.of(context).pop();
    ShowDialog().showAlertDialog(context, 'Processing');
    SharedP.sharedPreferences
        .setString('Mobile Number', _phoneNumberController.text);
    print(SharedP.sharedPreferences.getString('Mobile Number'));
    _messaging.getToken().then((token) {
      SharedP.sharedPreferences.setString('Token', token);
      // String tokenString = _prefs.getString('Token');
      // print('Token String Is:  $tokenString');
      SharedP.cloudFunctions
          .getHttpsCallable(functionName: 'addUserToken')
          .call({
        'token': token,
        'Phone No': _phoneNumberController.text,
      });
    });
    new Timer(Duration(seconds: 5), () {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        PageTransition(
          builder: (context) => AfterLogin(),
        ),
      );
    });

    print('Successful authetication');
    // setState(() {});
    // Navigator.of(context).pop();
  }

  void _signInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      onVerificationSuccess();
      //     .then((FirebaseUser user) async {
      //   final FirebaseUser currentUser = await _auth.currentUser();
      //   assert(user.uid == currentUser.uid);
      //   print('signed in with phone number successful: user -> $user');
      // });
    } on PlatformException catch (e) {
      if (e.message.contains(
          'The sms verification code used to create the phone auth credential is invalid')) {
        print('Wrong Code');
        Navigator.of(context).pop();
        ShowSnackBar().showSnackBar(
            context, 'Wrong Verification Code 😓', SharedP.scaffoldState);
      } else if (e.message.contains('The sms code has expired')) {
        print('Wrong code 2');
        Navigator.of(context).pop();
        ShowSnackBar()
            .showSnackBar(context, 'Time Out 😓', SharedP.scaffoldState);
      }
    }

    //  await FirebaseAuth.instance
    //     .signInWithPhoneNumber(
    //       verificationId: verificationId,
    //       smsCode: smsCode)
    //     .then((FirebaseUser user) async {
    //       final FirebaseUser currentUser = await _auth.currentUser();
    //       assert(user.uid == currentUser.uid);
    //       print('signed in with phone number successful: user -> $user');
    //     });
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    // String _smsCode;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(10.0),
            content: Container(
              // width: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                          fontSize: 18.0, color: Theme.of(context).accentColor),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: 'Verification Code',
                        labelStyle: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      cursorColor: Theme.of(context).accentColor,
                      // onChanged: (value) {
                      //   _smsCode = value;
                      // },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      print('_controller.text :');
                      print(_controller.text);
                      FocusScope.of(context).unfocus();
                      _signInWithPhoneNumber(_controller.text.toString());
                      _controller.clear();
                    },
                    // padding: const EdgeInsets.symmetric(vertical: 15.0),
                    // color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    // splashColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SharedP.scaffoldState,
      backgroundColor: Theme.of(context).accentColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 250,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: TextField(
                        controller: _phoneNumberController,
                        // enabled: !loading,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Theme.of(context).accentColor,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                            labelText: 'Mobile Number (+91)',
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 1.2,
                            ),
                            // errorText: _phoneNumberController.text,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            )),
                        cursorColor: Theme.of(context).primaryColor,
                        // onChanged: (value) {
                        //   print('${snapshot.data.toString()}');
                        //   _loginBloc.checkPhoneValidation(value.toString());
                        // },
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        // Todo
                        if (_phoneNumberController.text.length == 10) {
                          // _phoneNumber =
                          // '+91${_loginBloc.loginCheck.phoneNumber}';
                          _sendCodeToPhoneNumber(
                              '+91${_phoneNumberController.text}');                              
                          smsCodeDialog(context);
                        } else {
                          ShowSnackBar().showSnackBar(context,
                              'Invalid Phone Number 😔', SharedP.scaffoldState);
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          letterSpacing: 1.5,
                          // fontFamily: 'Gotham Light',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FlareActor(
                      'assets/Animation/Sai Collections logo.flr',
                      animation: 'rotate',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('Dispose Called');
    _phoneNumberController.dispose();
    _controller.dispose();
    super.dispose();
  }
}

class AfterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
          Text(
            'Successfully Sign In',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          // SizedBox(
          //   height: 20.0,
          // ),
          // RaisedButton(
          //   child: Text(
          //     'Let\'s Go',
          //     style: TextStyle(
          //         color: Theme.of(context).primaryColor, fontSize: 18.0),
          //   ),
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //       context,
          //       PageTransition(
          //         child: HomePage(),
          //         type: PageTransitionType.rightToLeftWithFade,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      floatingActionButton: RaisedButton(
        child: Text(
          'Let\'s Go',
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              builder: (context) => HomePage(),
            ),
          );
        },
      ),
    );
  }
}

// ! Junk Code

// child: Stack(
//   children: <Widget>[
//     FlareActor(
//       'assets/Animation/Mountain.flr',
//       animation: 'rotate',
//       // isPaused: false,
//       alignment: Alignment.topCenter,
//       sizeFromArtboard: true,
//       // fit: BoxFit.cover,
//     ),
//     Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // mainAxisSize: MainAxisSize.min,
//         // shrinkWrap: true,
//         children: <Widget>[
//           // Container(
//           //   margin: EdgeInsets.only(bottom: 10.0),
//           //   height: 60.0,
//           //   child: Image.asset(
//           //       'assets/logo/sai collection logo.png'),
//           //   // child: FlareActor(
//           //   //   "assets/logo/sai collection logo.flr",
//           //   //   animation: 'fade',

//           //   // ),
//           // ),
//           // Text('Sai Collection'),
//           Container(
//             height: 150.0,
//             child: FlareActor(
//               'assets/Animation/Sai Collections logo.flr',
//               animation: 'rotate',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 30.0, vertical: 20.0),
//             child: TextField(
//               controller: _phoneNumberController,
//               // enabled: !loading,
//               style: TextStyle(
//                 fontSize: 22.0,
//                 color: Theme.of(context).primaryColor,
//               ),
//               keyboardType: TextInputType.number,
//               maxLength: 10,
//               decoration: InputDecoration(
//                   labelText: 'Mobile Number (+91)',
//                   labelStyle: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     // letterSpacing: 1.2,
//                   ),
//                   // errorText: _phoneNumberController.text,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   )
//                   // border: OutlineInputBorder(
//                   //   borderRadius: BorderRadius.circular(20.0),
//                   //   borderSide: BorderSide(
//                   //       color: Theme.of(context).accentColor),
//                   // ),
//                   // hintStyle: TextStyle(),
//                   // focusedBorder: OutlineInputBorder(
//                   //   borderRadius: BorderRadius.circular(20.0),
//                   //   borderSide: BorderSide(
//                   //       color: Theme.of(context).accentColor),
//                   // ),
//                   ),
//               cursorColor: Theme.of(context).primaryColor,
//               // onChanged: (value) {
//               //   print('${snapshot.data.toString()}');
//               //   _loginBloc.checkPhoneValidation(value.toString());
//               // },
//             ),
//           ),
//           // loading
//           //     ? Center(
//           //         child: CircularProgressIndicator(
//           //           valueColor: AlwaysStoppedAnimation<Color>(
//           //               Theme.of(context).primaryColorDark),
//           //         ),
//           //       )
//           //     :
//           RaisedButton(
//             onPressed: () async {
//               // print(
//               //     'Phone Number: ${_loginBloc.loginCheck.phoneNumber}');
//               // if (!snapshot.hasError &&
//               //     _loginBloc.loginCheck.phoneNumber != null) {
//               //   _phoneNumber =
//               //       '+91${_loginBloc.loginCheck.phoneNumber}';
//               //   _sendCodeToPhoneNumber();
//               //   smsCodeDialog(context);
//               // }
//               // smsCodeDialog(context);
//               // Todo
//               if (_phoneNumberController.text.length == 10) {
//                 // _phoneNumber =
//                 // '+91${_loginBloc.loginCheck.phoneNumber}';
//                 _sendCodeToPhoneNumber(
//                     '+91${_phoneNumberController.text}');
//                 smsCodeDialog(context);
//               } else {
//                 ShowSnackBar().showSnackBar(
//                     context, SharedP.scaffoldState, 'Invalid Phone Number 😔');
//               }
//               // ShowDialog().showAlertDialog(context, 'Processing');
//               // Navigator.of(context).push(MaterialPageRoute(
//               // builder: (context) => AfterLogin()));
//               // smsCodeDialog(context);
//               // ver
//               // });
//             },
//             // _loginBloc.loginCheck.enable ?
//             // : null,
//             // padding: const EdgeInsets.symmetric(
//             //     vertical: 15.0, horizontal: 50.0),
//             child: Text(
//               'Sign In',
//               style: TextStyle(
//                 color: Theme.of(context).primaryColor,
//                 fontSize: 18.0,
//                 letterSpacing: 1.5,
//                 // fontFamily: 'Gotham Light',
//               ),
//             ),
//             // color: Theme.of(context).accentColor,
//             // shape: new RoundedRectangleBorder(
//             //   borderRadius:
//             //       new BorderRadius.circular(30.0),
//             // ),
//             // borderSide: BorderSide(
//             // color: Theme.of(context).accentColor,
//             // ),
//             // color: Theme.of(context).primar,
//             // splashColor: Theme.of(context).primaryColor,
//             // highlightedBorderColor:
//             // Theme.of(context).accentColor,
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
