import 'package:flutter/material.dart';
// 
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';

class Account extends StatefulWidget {
  // bool _accountDetailsPresent;

  // Account(this._accountDetailsPresent);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // final _accountDetailsBloc = AccountDetailsBloc();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  // String _errorText;
  double height;
  bool _accountDetailsPresent = false;
  // bool callOrNot = true;

  var textControllerName = TextEditingController();
  var textControllerHouseNo = TextEditingController();
  var textControllerColony = TextEditingController();
  var textControllerLandmark = TextEditingController();

  // SharedPreferences prefs;

  // @override
  // void initState() {
  //   print('init called');
  //   super.initState();
  //   // createSharedPreferences();
  // }

  @override
  void initState() {
    print('init is called');
    // createSharedPreferences();
    _setSharedPreferencesValues();
    super.initState();
  }

  // createSharedPreferences() async {
  //   print('create shared Preferences called');
  //   prefs = await SharedPreferences.getInstance();
  //   _setSharedPreferencesValues();
  // }

  _setSharedPreferencesValues() {
    // print(prefs.getString('Mobile Number'));
    if (SharedP.sharedPreferences.getString('Name') != null) {
      _accountDetailsPresent = true;
      // print(prefs.getString('Mobile Number'));
      // } else {

      // textControllerName.text = _prefs.getString('Name');
      // textControllerHouseNo.text = _prefs.getString('House No');
      // textControllerColony.text = _prefs.getString('Colony');
      // textControllerLandmark.text = _prefs.getString('Landmark');
      getValuesCache(SharedP.sharedPreferences);
      setState(() {});
    }
  }

  Widget showAccountDetails() {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Name
          SizedBox(
            height: 30.0,
          ),
          Text(
            textControllerName.text.toUpperCase(),
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                // letterSpacing: 1.2,
                color: Theme.of(context).accentColor),
            // textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            // _accountDetailsBloc.accountDetailsClass.houseNo + '',
            textControllerHouseNo.text,
            style:
                TextStyle(fontSize: 20.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            // _accountDetailsBloc.accountDetailsClass.colony + '',
            textControllerColony.text,
            style:
                TextStyle(fontSize: 20.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            // _accountDetailsBloc.accountDetailsClass.landmark + '',
            textControllerLandmark.text,
            style:
                TextStyle(fontSize: 20.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Wardha',
            style: TextStyle(
                fontSize: 24.0,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget addAccountDetails(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          // controller: TextEditingController()
          //   ..text = _accountDetailsBloc.accountDetailsClass.name,
          // controller: textEditingController
          //   ..text = _accountDetailsBloc.accountDetailsClass.name == null
          //       ? null
          //       : _accountDetailsBloc.accountDetailsClass.name,
          // controller: _controller,
          controller: textControllerName,
          style:
              TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
          decoration: InputDecoration(
            hintText: 'Full Name',
            // hintStyle: TextStyle(color: Theme.of(context).primaryColorDark),
            // errorText: _errorText,
            // errorStyle: TextStyle(color: Theme.of(context).accentColor),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          cursorColor: Theme.of(context).accentColor,
          // onChanged: (value) {
          //   // textControllerName.text = value;
          // },
        ),
        TextField(
          // controller: _controller,
          style:
              TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
          // keyboardType: TextInputType.number,
          // maxLength: 6,
          // textAlign: TextAlign.start,
          controller: textControllerHouseNo,
          decoration: InputDecoration(
            hintText: 'Flat / House No. / Floor ',
            // hintStyle: TextStyle(color: Theme.of(context).primaryColorDark),
            // errorText: _errorText,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          cursorColor: Theme.of(context).accentColor,
          // onChanged: (value) {
          //   // textControllerHouseNo.text = value;
          //   print('on change called');
          // },
          // onSubmitted: (value){
          // print(value);
          // },
        ),
        // SizedBox(
        //   height: 30.0,
        // ),
        TextField(
          // controller: TextEditingController()
          //   ..text = _accountDetailsBloc.accountDetailsClass.colony,
          // controller: _controller,
          controller: textControllerColony,
          style:
              TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
          // keyboardType: TextInputType.number,
          // maxLength: 6,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: 'Colony / Street / Locality ',
            // hintStyle: TextStyle(color: Theme.of(context).primaryColorDark),
            // errorText: _errorText,
            // errorStyle: TextStyle(color: Theme.of(context).accentColor),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          cursorColor: Theme.of(context).accentColor,
          // onChanged: (value) {
          //   // textControllerColony.text = value;
          //   // textControllerColony.text = value;
          // },
        ),
        // SizedBox(
        //   height: 30.0,
        // ),
        TextField(
          // controller: TextEditingController()
          //   ..text = _accountDetailsBloc.accountDetailsClass.landmark,
          // controller: _controller,
          controller: textControllerLandmark,
          style:
              TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
          // keyboardType: TextInputType.number,
          // maxLength: 6,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: 'Landmark',
            // hintStyle: TextStyle(color: Theme.of(context).primaryColorDark),
            // errorText: _errorText,
            // errorStyle: TextStyle(color: Theme.of(context).accentColor),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          cursorColor: Theme.of(context).accentColor,
          // onChanged: (value) {
          //   // textControllerLandmark.text = value;
          //   // textControllerLandmark.value = TextEditingValue(text: value);
          //   print('on change called');
          //   // textControllerLandmark.text = value;
          // },
          // onSubmitted: (value) {
          // },
        ),
        // SizedBox(
        //   height: 30.0,
        // ),
        TextField(
          enabled: false,
          style:
              TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            labelText: 'Wardha',
            labelStyle:
                TextStyle(fontSize: 24.0, color: Theme.of(context).accentColor),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          cursorColor: Theme.of(context).accentColor,
        ),
      ],
    );
    // );
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {});
    // _accountDetailsBloc.accountDetailsClass.accountDetailPresent =
    //     accountDetailsPresent;
    // sample();
    height = MediaQuery.of(context).size.height;
    // createSharedPreferences();
    // if (mounted) {
    // }
    // setState(() {});
    // return ScopedModelDescendant<SharedPreferencesModel>(
    //     builder: (context, child, model) {
    //   if (callOrNot) {
    //     model.creationOfSharedPrefs();
    //     _setSharedPreferencesValues(model.prefs);
    //   }
    return Scaffold(
      key: _scaffoldState,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBarCreate().appbarCreate(context, 'My Account'),
      body:
          // OfflineBuilder(
          //     child: SizedBox(),
          //     connectivityBuilder: (BuildContext context,
          //         ConnectivityResult connectivity, Widget child) {
          //       final bool connected = connectivity != ConnectivityResult.none;
          //       return connected
          //           ?
          SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
          height: height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Theme.of(context).accentColor,
              width: 2.0,
            ),
          ),
          // child: widget.account ? showAccountDetails() : addAccountDetails(),
          child: _accountDetailsPresent
              ? showAccountDetails()
              : addAccountDetails(context),
        ),
      ),
      //       : Center(
      //           child: Text(
      //             'No Internet Connection 😴',
      //             style: TextStyle(
      //                 color: Theme.of(context).accentColor, fontSize: 20.0),
      //           ),
      //         );
      // }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _accountDetailsPresent
              ? RaisedButton(
                  // padding: const EdgeInsets.symmetric(
                  //     vertical: 15.0, horizontal: 30.0),
                  child: Text(
                    'Change Details',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontFamily: 'Gotham Light'),
                  ),
                  // color: Theme.of(context).accentColor,
                  onPressed: () {
                    // _accountDetailsBloc.accountSinkAdd(null);
                    // model.prefs.setBool('Account Details', false);
                    setValuesCache(SharedP.sharedPreferences);
                    print('Change called');
                    _accountDetailsPresent = false;
                    setState(() {
                      // callOrNot = false;
                    });
                  },
                  // shape: new RoundedRectangleBorder(
                  //   borderRadius: new BorderRadius.circular(30.0),
                  // ),
                  // borderSide:
                  //     BorderSide(color: Theme.of(context).accentColor),
                  // highlightedBorderColor: Theme.of(context).accentColor,
                  // splashColor: Theme.of(context).primaryColor,
                )
              : RaisedButton(
                  // padding: const EdgeInsets.symmetric(
                  //     vertical: 15.0, horizontal: 30.0),
                  child: Text(
                    'Save Now',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                  // color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (textControllerName.text.isEmpty ||
                        textControllerColony.text.isEmpty ||
                        textControllerLandmark.text.isEmpty) {
                      // print('correct');
                      // _errorText = 'This Field Can\'t Be Empty';
                      ShowSnackBar().showSnackBar(
                          context, 'All Fields Are Mandatory', _scaffoldState);
                      // setState(() {});
                    } else {
                      _accountDetailsPresent = true;
                      // model.prefs.setBool(
                      //     'Account Details', _accountDetailsPresent);
                      // _accountDetailsBloc.accountSinkAdd(
                      //     _accountDetailsBloc.accountDetailsClass);
                      setValuesCache(SharedP.sharedPreferences);
                      // _errorText = null;
                      // _accountDetailsBloc.accountSinkAdd(
                      //     _accountDetailsBloc.accountDetailsClass);
                      // print(_accountDetailsBloc.accountDetailsClass.name);
                    }
                    print(SharedP.sharedPreferences.getString('Name'));
                    print(SharedP.sharedPreferences.getString('House No'));
                    print(SharedP.sharedPreferences.getString('Colony'));
                    print(SharedP.sharedPreferences.getString('Landmark'));
                    // callOrNot = true;
                    setState(() {});
                    // print(snapshot.data);
                  },
                  // shape: new RoundedRectangleBorder(
                  //   borderRadius: new BorderRadius.circular(30.0),
                  // ),
                  // borderSide:
                  //     BorderSide(color: Theme.of(context).accentColor),
                  // highlightedBorderColor: Theme.of(context).accentColor,
                  // splashColor: Theme.of(context).accentColor,
                ),
          SizedBox(
            height: 20.0,
          ),
          _accountDetailsPresent
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            // contentPadding: EdgeInsets.only(top: 10.0),
                            title: Text(
                              'These Service Only Available in WARDHA 😔 For Now. You Can Add Address & Name Of Your Friend Also.',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  height: 2.0,
                                  fontWeight: FontWeight.w600),
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
                                    },
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 30.0, vertical: 15.0),
                                    child: Center(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0,
                                          // letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                    // color: Theme.of(context).accentColor,
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(30.0))
                                    // splashColor: Theme.of(context).accentColor,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    'Not A Wardha Resident?',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Gotham Light',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
    // });
  }

  setValuesCache(prefs) {
    prefs.setString('Name', textControllerName.text);
    prefs.setString('House No', textControllerHouseNo.text);
    prefs.setString('Colony', textControllerColony.text);
    prefs.setString('Landmark', textControllerLandmark.text);
  }

  getValuesCache(prefs) {
    textControllerName.text = prefs.getString('Name');
    textControllerHouseNo.text = prefs.getString('House No');
    textControllerColony.text = prefs.getString('Colony');
    textControllerLandmark.text = prefs.getString('Landmark');
  }

  @override
  void dispose() {
    textControllerName.dispose();
    textControllerHouseNo.dispose();
    textControllerColony.dispose();
    textControllerLandmark.dispose();
    super.dispose();
  }
}
