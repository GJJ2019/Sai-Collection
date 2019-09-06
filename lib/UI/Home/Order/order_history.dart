import 'package:flutter/services.dart' show Clipboard, ClipboardData;
//
import 'package:flutter/material.dart';
//
import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';

class MyOrders extends StatelessWidget {
  final mobileNumber;
  MyOrders(this.mobileNumber);
  // final _cloudFirestore = Firestore();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // return OfflineBuilder(
    //   child: SizedBox(),
    //   connectivityBuilder: (BuildContext context,
    //       ConnectivityResult connectivity, Widget child) {
    //     bool connected = !(connectivity == ConnectivityResult.none);
    //     if (connected) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBarCreate().appbarCreate(context, 'My Orders'),
      body: StreamBuilder(
        stream: SharedP.firestore
            .collection('Users')
            .document('orders')
            .collection(mobileNumber)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColorDark),
              ),
            );
          } else {
            if (snapshot.hasData || snapshot.error) {
              if (snapshot.data.documents.length == 0) {
                return Center(
                  child: Text(
                    'No Orders 😔',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text:
                                '${snapshot.data.documents[index]['Transaction Id']}'));
                        ShowSnackBar().showSnackBar(
                            context,
                            "Transaction Id Copied Successfully",
                            _scaffoldState);
                      },
                      child: Container(
                        height: 200.0,
                        // color: Colors.amber,
                        // margin: const EdgeInsets.symmetric(
                        //     horizontal: 10.0, vertical: 10.0),
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // border: Border.all(color: Theme.of(context).accentColor),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColorLight,
                              blurRadius:
                                  10.0, // has the effect of softening the shadow
                              spreadRadius:
                                  3.0, // has the effect of extending the shadow
                              offset: Offset(
                                7.0, // horizontal, move right 10
                                7.0, // vertical, move down 10
                              ),
                            )
                          ],
                          // border: Border.all(
                          //     color: Theme.of(context).accentColor, width: 0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data.documents[index]['Image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name : ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    '${snapshot.data.documents[index]['Name Of Product']}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        // letterSpacing: 1.1,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    'Date :',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    '${snapshot.data.documents[index]['Date']}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        // letterSpacing: 1.1,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  // Text(
                                  //   'Price: \u20B9 700',
                                  //   style: TextStyle(
                                  //       fontSize: 12.0,
                                  //       // letterSpacing: 1.1,
                                  //       color: Theme.of(context).accentColor),
                                  // ),
                                  Text(
                                    'Product Id : ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    '${snapshot.data.documents[index]['Product Id']}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        // letterSpacing: 1.1,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    'Size : ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    '${snapshot.data.documents[index]['Size']}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        // letterSpacing: 1.1,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    'Transaction Id : ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    '${snapshot.data.documents[index]['Transaction Id']}',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        // letterSpacing: 1.1,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }
          return SizedBox();
        },
      ),
    );
  }
}
