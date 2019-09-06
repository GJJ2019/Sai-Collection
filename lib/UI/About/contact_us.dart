// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;
//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/UI/Components/show_dialog.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';

class ContactUs extends StatefulWidget {
  // ContactUs({Key key}) : super(key: key);
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var _subject = TextEditingController();

  var _description = TextEditingController();

  var _transactionId = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBarCreate().appbarCreate(context, 'Contact Us'),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: _subject,
            style:
                TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
            decoration: InputDecoration(
              labelText: 'Subject',
              labelStyle: TextStyle(color: Theme.of(context).accentColor),
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
            ),
            cursorColor: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 50.0,
          ),
          TextField(
            controller: _transactionId,
            style:
                TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
            decoration: InputDecoration(
              labelText: 'Transaction Id (Optional)',
              labelStyle: TextStyle(color: Theme.of(context).accentColor),
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
            ),
            cursorColor: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 50.0,
          ),
          TextField(
            controller: _description,
            style:
                TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor),
            decoration: InputDecoration(
              labelText: 'Details',
              labelStyle: TextStyle(color: Theme.of(context).accentColor),
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
            ),
            cursorColor: Theme.of(context).accentColor,
            maxLines: 8,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () async {
              //   print("""
              //   Subject : ${_subject.text}
              //   Description : ${_description.text}
              // """);
              if (SharedP.sharedPreferences.getString('Name') == null) {
                ShowDialog().showAccountCompletionDialog(context);
              } else {
                if (_subject.text.isEmpty || _description.text.isEmpty) {
                  ShowSnackBar().showSnackBar(
                      context, 'Please Enter Valid Data', _scaffoldState);
                } else {
                  SharedP.firestore
                      .collection('Admin')
                      .document('email')
                      .get()
                      .then((email) async {
                    String description =
                        '${_description.text}\n\n Mobile Number : ${SharedP.sharedPreferences.getString('Mobile Number')} \n\n Name : ${SharedP.sharedPreferences.getString('Name')}\n\n House No : ${SharedP.sharedPreferences.getString('House No')}\n\n Colony : ${SharedP.sharedPreferences.getString('Colony')}\n\n Landmark : ${SharedP.sharedPreferences.getString('Landmark')}';
                    if (_transactionId.text.isNotEmpty) {
                      if (_transactionId.text.length < 10) {
                        ShowSnackBar().showSnackBar(context,
                            'Enter Valid transaction Id', _scaffoldState);
                        return;
                      } else {
                        description =
                            '${_description.text} \n\n Transaction Id : ${_transactionId.text}';
                      }
                    }
                    var url =
                        'mailto:${email.data['email-id']}?subject=${_subject.text}&body=$description';
                    if (await canLaunch(url)) {
                      print(description);
                      await launch(url);
                      _subject.clear();
                      _description.clear();
                      _transactionId.clear();
                    } else {
                      ShowSnackBar().showSnackBar(
                          context,
                          'Sorry You Don\'t Have App To Perform Action',
                          _scaffoldState);
                    }
                  });
                }
              }
            },
            child: Text(
              'Report',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                letterSpacing: 1.2,
              ),
            ),
            // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            // color: Theme.of(context).primaryColorDark,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(35.0),
            // ),
            // splashColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Note: ',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '- Add Transaction Id if related to product. You can copy that by clicking on Order from My-Orders page. \n- Report A Bug/ Problem With Proper Description.\n- We Will Reach You As Soon As Possible.',
            style: TextStyle(fontSize: 16.0, height: 1.5),
            // strutStyle: StrutStyle(height: 1.1),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: ,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _description.dispose();
    _transactionId.dispose();
    _subject.dispose();
    super.dispose();
  }
}
