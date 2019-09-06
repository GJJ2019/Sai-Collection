import 'package:flutter/material.dart';
//
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:url_launcher/url_launcher.dart';
//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/appbar.dart';

class CheckForUpdate extends StatelessWidget {
  Future<bool> checkForUpdate() async {
    // await Firestore.instance
    //     .collection('Admin')
    //     .document('version')
    //     .get()
    //     .then((data) async {
    //   if (data['version'] == SharedP.sharedPreferences.getInt('version')) {
    //     print('Version are Equal');
    //     return false;
    //   } else {
    //     print('Versions are not equal');
    //     return true;
    //   }
    // });

    DocumentSnapshot version =
        await SharedP.firestore.collection('Admin').document('version').get();

    print('Version is ${version['version']}');

    if (version['version'] == SharedP.sharedPreferences.getInt('version')) {
      return false;
    } else {
      return true;
    }

    // return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCreate().appbarCreate(context, 'Update'),
      body: FutureBuilder(
        future: checkForUpdate(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print('Data is ${snapshot.data}');
            return Center(
              child: snapshot.data
                  ? RaisedButton(
                      onPressed: () async {
                        await SharedP.firestore
                            .collection('Admin')
                            .document('app')
                            .get()
                            .then((data) async {
                          launch(data['app-link']);
                        });
                      },
                      child: Text(
                        'Check For Update',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          letterSpacing: 1.5,
                          // fontFamily: 'Gotham Light',
                        ),
                      ),
                    )
                  : Text(
                      'No Update Available 😄',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColorDark),
            ));
          }
        },
      ),
      // body: Center(
      //   child: RaisedButton(
      //     onPressed: () async {
      //       Firestore.instance
      //           .collection('Admin')
      //           .document('version')
      //           .get()
      //           .then((data) async {
      //         if (data['version'] !=
      //             SharedP.sharedPreferences.getInt('version')) {
      //           print('Version are Equal');
      //         } else {
      //           launch(
      //               'https://firebasestorage.googleapis.com/v0/b/sai-collections-release.appspot.com/o/Nike%20third%2FNike%20third%200.jpg?alt=media&token=4e882bf1-e1b2-4fb9-94c9-fc277f1d6f2e');
      //           print('Versions are not equal');
      //         }
      //       });
      //     },
      //     child: Text(
      //       'Check For Update',
      //       style: TextStyle(
      //         color: Theme.of(context).primaryColor,
      //         fontSize: 18.0,
      //         letterSpacing: 1.5,
      //         // fontFamily: 'Gotham Light',
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
