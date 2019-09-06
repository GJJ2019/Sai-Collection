import 'package:flutter/material.dart';
//
import 'package:flutter_upi/flutter_upi.dart';
//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/generate_random.dart';
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/UI/Components/show_dialog.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';
import 'package:sai_collection/UI/Home/Payment/successful_screen.dart';

class Payment extends StatefulWidget {
  final _image,
      _name,
      _mobileNumber,
      _productName,
      _productId,
      _houseNo,
      _colony,
      _landmark,
      _amount,
      _category,
      _size;
      // _listOfSizes;
  // _documentId;
  Payment(
      this._image,
      this._name,
      this._mobileNumber,
      this._productName,
      this._productId,
      this._houseNo,
      this._colony,
      this._landmark,
      this._amount,
      this._category,
      this._size,
      // this._listOfSizes
      // this._documentId
      );

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // final _cloudFirestore = Firestore();

  // final _cloudFunction = CloudFunctions.instance;

  // final _storage = FirebaseStorage.instance;

  GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print("""
     _image : ${widget._image}
      _name : ${widget._name},
      _mobileNumber : ${widget._mobileNumber},
      _productId : ${widget._productId},
      _colony : ${widget._colony},
      _amount : ${widget._amount}
      _productName : ${widget._productName},
      _houseNo : ${widget._houseNo},
      _landmark : ${widget._landmark},
      _category : ${widget._category},
    """);

    // return FutureBuilder(
    //     future: Connectivity().checkConnectivity(),
    //     builder: (BuildContext context,
    //         AsyncSnapshot<ConnectivityResult> connectivityResult) {
    //       if (connectivityResult.connectionState == ConnectionState.done) {
    //         bool connection =
    //             !(connectivityResult.data == ConnectivityResult.none);
    //         if (connection) {
    return Scaffold(
        key: _scaffoldState,
        // backgroundColor: Colors.transparent,
        appBar: AppBarCreate().appbarCreate(context, 'Payment'),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 30.0,
            // vertical: 10.0,
          ),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Container(
                  height: 30.0,
                  // width: 100.0,
                  child: Image.asset('assets/logo/bhim.png'),
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.BHIMUPI);
                  // ShowSnackBar().showSnackBar(context, _scaffoldState,
                  //     'This Feature Is Under Development. Sorry For Inconvenience 😓');
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Container(
                  height: 30.0,
                  // width: 100.0,
                  child: Image.asset('assets/logo/phonepay.png'),
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.PhonePe);
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Container(
                  height: 30.0,
                  // width: 100.0,
                  child: Image.asset('assets/logo/googlepay.png'),
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.GooglePay);
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                child: Container(
                  height: 30.0,
                  // width: 100.0,
                  child: Image.asset('assets/logo/amazonpay.png'),
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.AmazonPay);
                  // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  // getUpiId(). .then((v){
                  //   print(_upi);
                  // });
                  // DocumentSnapshot _querySnapshot = await _cloudFirestore
                  //     .collection("Admin")
                  //     .document('upi-id')
                  //     .get().then((v){

                  //     });

                  // print('Data is ${_querySnapshot.data['upi']}');
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      // width: 100.0,
                      child: Image.asset('assets/logo/airtel.png'),
                      padding: const EdgeInsets.only(right: 20.0),
                    ),
                    Text(
                      'Airtel',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.MyAirtelUPI);
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Text(
                  'TrueCaller Upi',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24.0,
                  ),
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.TrueCallerUPI);
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Text(
                  'MI Pay',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24.0,
                  ),
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.MiPay);
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SuccessfulScreen()),
                  //     (_) => false);
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      // width: 100.0,
                      child: Image.asset('assets/logo/paytm.png'),
                    ),
                    // Text(
                    //   'Pay',
                    //   style: TextStyle(
                    //     color: Theme.of(context).accentColor,
                    //     fontSize: 24.0,
                    //     letterSpacing: 1.5,
                    //     // fontFamily: 'Gotham Light',
                    //   ),
                    // ),
                  ],
                ),
                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                onPressed: () async {
                  payment(context, FlutterUpiApps.PayTM);
                  // ShowSnackBar().showSnackBar(context, _scaffoldState,
                  //     'This Feature Is Under Development. Sorry For Inconvenience 😓');
                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
                // splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
                // highlightedBorderColor: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ));
    //     } else {
    //       // return Offline();
    //       return Scaffold(
    //         body: Offline().offline(),
    //         floatingActionButton: FloatingActionButton(
    //           onPressed: () {
    //             setState(() {});
    //           },
    //           child: Icon(Icons.refresh),
    //           mini: true,
    //         ),
    //         floatingActionButtonLocation:
    //             FloatingActionButtonLocation.endFloat,
    //       );
    //     }
    //   } else {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    // });

    // getUpiId();
    // _database.reference().child('Admin/upi').once().then((value) {
    //   print(value);
    // });

    // return OfflineBuilder(
    //   child: SizedBox(),
    //   connectivityBuilder: (BuildContext context,
    //       ConnectivityResult connectivity, Widget child) {
    //     bool connected = !(connectivity == ConnectivityResult.none);
    //     if (connected) {

    //     } else {
    //       return Offline();
    //     }
    //   },
    // );
  }

  payment(BuildContext context, String app) async {
    // try {
    //   DocumentSnapshot documentSnapshot =  await SharedP.firestore.document("Admin/upi-id").get();
    //   print('Upi Id is ${documentSnapshot['upi']}');
    // } on PlatformException catch (e) {
    //   ShowSnackBar().showSnackBar(context, 'You Are Offline', _scaffoldState);
    // }

    // try {
    await SharedP.firestore
        .collection("Admin")
        .document('upi-id')
        .get()
        .catchError((error) {
      ShowSnackBar().showSnackBar(context, 'You Are Offline', _scaffoldState);
    }).then((v) async {
      print('upi id is ${v['upi']}');
      String response = await FlutterUpi.initiateTransaction(
        app: app,
        pa: v['upi'],
        pn: "Sai Collection",
        tr: GenerateRandom().generateRandomNumber(10),
        tn: "Proceed Payment To Buy ${widget._productName}",
        am: widget._amount.toString(),
        // am: '5',
        // mc: "Sai Collection", // optional
        cu: "INR",
        url: "https://www.google.com",
      );

      // FlutterUpiResponse flutterUpiResponse = FlutterUpiResponse(response);
      print('Response is : $response');
      // _afterPayment(context, 'rgoihsdgohsdogihsdog');
      // TODO -: Check whether payments are working or not ???????????
      switch (response) {
        case 'app_not_installed':
          ShowSnackBar()
              .showSnackBar(context, 'App Is Not Install', _scaffoldState);
          break;
        case 'user_canceled':
          ShowSnackBar().showSnackBar(
              context, 'Successfully Cancelled Transaction', _scaffoldState);
          break;
        case 'invalid_params':
          ShowSnackBar()
              .showSnackBar(context, 'Something Went Wrong', _scaffoldState);
          break;
        case 'null_response':
          ShowSnackBar()
              .showSnackBar(context, 'Empty Responses', _scaffoldState);
          break;
        default:
          // TODO Check Whether Transaction Successul Or Not
          FlutterUpiResponse flutterUpiResponse = FlutterUpiResponse(response);
          if (flutterUpiResponse.responseCode == '00') {
            assert(flutterUpiResponse.responseCode == '00');
            _afterPayment(context, flutterUpiResponse.txnId);
          } else {
            ShowSnackBar()
                .showSnackBar(context, 'Transaction Failed', _scaffoldState);
          }
          break;
      }
      //   // print(response);
    });
    // } on PlatformException catch (e) {}
  }

  _afterPayment(BuildContext context, String transactionId) async {
    // _settingBottomSheet(context);
    ShowDialog().showAlertDialog(context, 'Processing');
    // Timer(Duration(seconds: 10), () {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => SuccessfulScreen(),
    //     ),
    //     (_) => false,
    //   );
    // });
    //  TODO  = delete the product which is ordered with Images Of Product except one
    // TODO Implement Below -:
    // if (widget._listOfSizes.length == 1) {
    //   // Delete all images except 1
    //   for (var i = 1; i < widget._image.length; i++) {
    //     FirebaseStorage.instance
    //         .ref()
    //         .child(widget._productId)
    //         .child('${widget._productId} $i.jpg')
    //         .delete();
    //   }
    // Delete that size of product -:
    await SharedP.cloudFunctions
        .getHttpsCallable(functionName: 'deleteSizeOfProduct')
        .call({
      'Category': widget._category,
      'Product Id': widget._productId,
      'Size': widget._size
    });
    // }
    var date = new DateTime.now();
    await SharedP.cloudFunctions
        .getHttpsCallable(functionName: 'addOrderDetails')
        .call({
      'Image': widget._image.first,
      'Date': '${date.day}/${date.month}/${date.year}',
      'Name': widget._name,
      'Phone No': widget._mobileNumber,
      'Name Of Product': widget._productName,
      'Transaction Id': transactionId,
      'Product Id': widget._productId,
      'House No': widget._houseNo,
      'Colony': widget._colony,
      'Landmark': widget._landmark,
      'Size': widget._size,
      'Category': widget._category
    });

    await SharedP.cloudFunctions
        .getHttpsCallable(functionName: 'userOrderDetails')
        .call({
      'Image': widget._image.first,
      'Date': '${date.day}/${date.month}/${date.year}',
      'Phone No': widget._mobileNumber,
      'Name Of Product': widget._productName,
      'Product Id': widget._productId,
      'Transaction Id': transactionId,
      'Size': widget._size
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessfulScreen(),
      ),
      (_) => false,
    );
    // Navigator.of(context).popUntil(ModalRoute.of(context).)
  }
}
