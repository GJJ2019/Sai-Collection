import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppBarCreate {
  AppBar appbarCreate(
    BuildContext context,
    String title,
  ) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      backgroundColor: Theme.of(context).primaryColorDark,
      title: SafeArea(
        top: true,
        child: Text(
          // 'Payment',
          '$title',
          style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 20.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      // backgroundColor: Colors.transparent,
      // bottom: PreferredSize(
      //   child: Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
      //     color: Theme.of(context).accentColor,
      //     height: 1.0,
      //   ),
      //   preferredSize: Size.fromHeight(0.0),
      // ),
      // actions: <Widget>[
      //   // Text(
      //   //   'Rs 0',
      //   //   textAlign: TextAlign.center,
      //   // // )
      //   // IconButton(
      //   //   icon: Icon(Icons.account_balance_wallet),
      //   //   onPressed: () {},
      //   //   // padding: const EdgeInsets.only(right: 20.0),
      //   // ),
      //   showBalance
      //       ? GestureDetector(
      //           child: Center(
      //             child: Padding(
      //               padding: const EdgeInsets.only(right: 10.0, top: 5.0),
      //               child: Text(
      //                 '\u20B9 50',
      //                 style: TextStyle(fontSize: 20.0),
      //               ),
      //             ),
      //           ),
      //           onTap: () {
      //             print('Hey there');
      //           },
      //         )
      //       : Text(''),
      // ],
    );
  }
}
