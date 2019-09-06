import 'package:flutter/services.dart' show SystemNavigator;

//
import 'package:flutter/material.dart';

//
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;

//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/UI/Components/drawer_home.dart';
import 'package:sai_collection/UI/Home/Product/list_products.dart';

class HomePage extends StatelessWidget {
  Future<bool> _onWillPop(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
            title: Text(
              'Are You Sure 😥 ?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  // onPressed: () {
                  //   exit(0);
                  // } ,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'No',
                  ),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(5.0),
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(
                  width: 5.0,
                ),
                FlatButton(
                  onPressed: () => SystemNavigator.pop(),
                  // onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                  child: Text(
                    'Yes',
                  ),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(5.0),
                  color: Theme.of(context).accentColor,
                  // color: Theme.of(context).accentColor,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // return OfflineBuilder(
    //   child: SizedBox(),
    //   connectivityBuilder: (BuildContext context,
    //       ConnectivityResult connectivity, Widget child) {
    //     bool connected = !(connectivity == ConnectivityResult.none);
    //     if (connected) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        key: SharedP.scaffoldState,
        appBar: AppBarCreate().appbarCreate(context, 'Sai Collection'),
        // appBar: SliverAppBar(),
        // drawer: DrawerHome().drawer(context, _mobileNumber, _scaffoldState),
        drawer: DrawerHome().drawer(
            context, SharedP.sharedPreferences.getString('Mobile Number')),
        body: StreamBuilder(
          // key: PageStorageKey('stream builder'),
          stream: SharedP.firestore.collection('Category').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColorDark),
                ),
              );
            } else {
              if (snapshot.hasData) {
                if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text(
                      'No Internet Connection 😔',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2),
                    ),
                  );
                } else {
                  // return Container(
                  //   height: animation.value,
                  //   color: Theme.of(context).accentColor,
                  //   child: Text(
                  //     'Data',
                  //     style:
                  //         TextStyle(color: Theme.of(context).primaryColor),
                  //   ),
                  // );
                  return GridView.builder(
                      key: PageStorageKey('Home Page Builder'),
                      itemCount: snapshot.data.documents.length,
                      padding: EdgeInsets.only(bottom: 20.0),
                      // scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.7,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        // },
                        // children: <Widget>[
                        // for (var index = 0; index < results.length; index++)
                        return GestureDetector(
                          onTap: () {
                            PageController _pageController =
                                new PageController(initialPage: index);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PageView.builder(
                                  controller: _pageController,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // _animationController.stop();
                                    // _pageController.animateToPage(index,
                                    //     duration: Duration(milliseconds: 500));
                                    return ListProducts(
                                        snapshot.data.documents[index]
                                            ['category'],
                                        snapshot.data.documents[index]
                                            ['image']);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: snapshot.data.documents[index]['category'],
                            // transitionOnUserGestures: true,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 20.0),
                              // decoration: BoxDecoration(),
                              // margin: EdgeInsets.only(top: 5.0),
                              // height: 200.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                  // border: Border.all(
                                  //     color: Theme.of(context).primaryColor,
                                  //     width: 0.5),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(snapshot
                                        .data.documents[index]['image']),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.35),
                                      // animation.value,
                                      BlendMode.darken,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      spreadRadius: 2.5,
                                      offset: Offset(3.0, 3.0),
                                    ),
                                  ]),
                              child: Center(
                                child: Text(
                                  '${snapshot.data.documents[index]['category']}',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 36.0,
                                      height: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
              }
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

// ! Junk Code :
// return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           'Are you sure?',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: Text('Do you want to exit an App'),
//         actions: <Widget>[
//           RaisedButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: new Text('No'),
//             color: Theme.of(context).primaryColorDark,
//           ),
//           RaisedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: new Text('Yes'),
//             color: Colors.red,
//           ),
//         ],
//       ),
//     ) ??
//     false;
// child: Container(
//   margin: EdgeInsets.only(
//       left: 10.0, right: 10.0, top: 20.0),
//   // decoration: BoxDecoration(),
//   // margin: EdgeInsets.only(top: 5.0),
//   // height: 200.0,
//   decoration: BoxDecoration(
//       color: Theme.of(context).accentColor,
//       borderRadius: BorderRadius.circular(20.0),
//       // border: Border.all(
//       //     color: Theme.of(context).primaryColor,
//       //     width: 0.5),
//       image: DecorationImage(
//         image: NetworkImage(
//           snapshot.data.documents[index]['image'],
//         ),
//         fit: BoxFit.cover,
//         colorFilter: ColorFilter.mode(
//           Colors.black.withOpacity(0.35),
//           // animation.value,
//           BlendMode.darken,
//         ),
//       ),
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 5.0,
//           color:
//               Theme.of(context).primaryColorLight,
//           spreadRadius: 2.5,
//           offset: Offset(3.0, 3.0),
//         ),
//       ]),
//   child: Center(
//     child: Text(
//       '${snapshot.data.documents[index]['category']}',
//       style: TextStyle(
//         color: Theme.of(context).primaryColor,
//         fontSize: 36.0,
//       ),
//       textAlign: TextAlign.center,
//       strutStyle: StrutStyle(
//         fontSize: 16.0,
//         height: 3.0,
//       ),
//     ),
//   ),
// ),

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
// GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
// AnimationController _animationController;
// Animation<double> animation;
// Animation<double> animation;

// String _mobileNumber = '';
// SharedPreferences _prefs;
// final _cloudFirestore = Firestore();
// final _cloudFunction = CloudFunctions.instance;
// final FirebaseMessaging _messaging = FirebaseMessaging();
// List results;
// List imageUrl = [];
// TabController _tabcontroller;
// final AsyncMemoizer _memoizer = AsyncMemoizer();

// @override
// void initState() {
//   // WidgetsBinding.instance.addObserver(this);
//   super.initState();
//   createSharedPreferences();
// }

// @override
// void dispose() {
//   _animationController.dispose();
//   super.dispose();
// }

// createSharedPreferences() async {
//   _prefs = await SharedPreferences.getInstance();
//   _mobileNumber = _prefs.getString('Mobile Number');
//   setState(() {});
//   // setTokenForUser();
// }
// setTokenForUser() {
//   print('Mobile Number is -: $_mobileNumber');
//   String token = SharedP.sharedPreferences.getString('Token');
//   if (token == null) {
//     _messaging.getToken().then((token) {
//       SharedP.sharedPreferences.setString('Token', token);
//       String tokenString = SharedP.sharedPreferences.getString('Token');
//       print('Token String Is:  $tokenString');
//       _cloudFunction.getHttpsCallable(functionName: 'addUserToken').call({
//         'token': token,
//         'Phone No': _mobileNumber,
//       });
//     });
//   } else {
//     print('Token Is Present');
//     print('Token is $token');
//   }
// }

// getCategories() async {
//   _cloudFunction
//       .getHttpsCallable(functionName: 'getCategory')
//       .call({}).then((dataReceive) {
//     print('Results are $dataReceive');
//     results = dataReceive.data;
//     setState(() {});
//   });
// }

// getCategories() async {
//   // print('Widget Build is called');
//   // for (var list in _lists) {
//   //   print('Category is ${list.data['category']}');
//   //   _categories.add(list.data['category']);
//   //   print('l is $_categories');
//   // }
//   // return _categories;

//   QuerySnapshot _querySnapshot =
//       await _cloudFirestore.collection("Category").getDocuments();
//   var _lists = _querySnapshot.documents;
//   return _lists;
// }

// var accountDetailsPresent;

// bool _accountDetailsPresent =false;
// sample(prefs) {
//   _mobileNumber = prefs.getString('MobileNumber');
// }

// @override
// void initState() {
//   super.initState();
//   sample();
// }

// @override
// void initState() {

//   super.initState();
// }
// child: Container(
//   margin: EdgeInsets.only(
//       left: 2.0, right: 2.0, top: 5.0),
//   // decoration: BoxDecoration(),
//   // margin: EdgeInsets.only(top: 5.0),
//   // height: 200.0,
//   decoration: BoxDecoration(
//     color: Theme.of(context).accentColor,
//     borderRadius: BorderRadius.circular(20.0),
//     border: Border.all(
//         color: Theme.of(context).primaryColor,
//         width: 0.5),
//     // image: DecorationImage(
//     //   image: NetworkImage(
//     //     snapshot.data.documents[index]['image'],
//     //   ),
//     //   fit: BoxFit.cover,
//     //   colorFilter: ColorFilter.mode(
//     //     Theme.of(context).primaryColorLight,
//     //     // animation.value,
//     //     BlendMode.darken,
//     //   ),
//     // ),
//   ),
//   child: Center(
//     child: Text(
//       '${snapshot.data.documents[index]['category']}',
//       style: TextStyle(
//         color: Theme.of(context).primaryColor,
//         fontSize: 36.0,
//       ),
//       textAlign: TextAlign.center,
//       strutStyle: StrutStyle(
//         fontSize: 16.0,
//         height: 3.0,
//       ),
//     ),
//   ),
// ),
// backgroundColor: Color.fromRGBO(75, 75, 75, 1.0),
// body: NestedScrollView(
//     headerSliverBuilder:
//         (BuildContext context, bool innerBoxIsScrollin) {
//       return <Widget>[
//         SliverAppBar(
//           expandedHeight: 150.0,
//           floating: true,
//           pinned: true,
//           backgroundColor: Theme.of(context).primaryColorDark,
//           centerTitle: true,
//           iconTheme:
//               IconThemeData(color: Theme.of(context).primaryColor),
//           elevation: 5.0,
//           flexibleSpace: FlexibleSpaceBar(
//             // titlePadding: EdgeInsets.only(top: 80),
//             centerTitle: true,
//             title: Text(
//               'Sai Collection',
//               style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         )
//       ];
//     },
// body: results == null
//     ? Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(
//               Theme.of(context).primaryColorDark),
//         ),
//       )
//     : GridView.builder(
//         itemCount: results.length,
//         // padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 10.0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           // crossAxisSpacing: 5.0,
//           // mainAxisSpacing: 5.0,
//           childAspectRatio: 0.6,
//         ),
//     // padding: EdgeInsets.symmetric(horizontal: 5.0),
//     itemBuilder: (BuildContext context, int index) {
//       return GestureDetector(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => ListProducts(
//                   results[index]['category'],
//                   results[index]['image']),
//             ),
//           );
//         },
//         child:
// ListView.builder(
//     itemCount: results.length,
//     padding: EdgeInsets.only(top: 10.0),
// itemBuilder: (BuildContext context, int index) {
//   // },
//   // children: <Widget>[
//   // for (var index = 0; index < results.length; index++)
//   return GestureDetector(
//     onTap: () {
//       PageController _pageController =
//           new PageController(initialPage: index);
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageView.builder(
//             controller: _pageController,
//             itemCount: results.length,
//             itemBuilder: (BuildContext context, int index) {
//               // _pageController.animateToPage(index,
//               //     duration: Duration(milliseconds: 500));
//               return ListProducts(results[index]['category'],
//                   results[index]['image']);
//             },
//           ),
//         ),
//       );
//     },
//     child: Hero(
//       tag: results[index]['category'],
//       child: Container(
//         // margin: EdgeInsets.symmetric(horizontal: 10.0),
//         // decoration: BoxDecoration(),
//         height: 200.0,
//         decoration: BoxDecoration(
//           border:
//               Border.all(color: Theme.of(context).primaryColor),
//           image: DecorationImage(
//             image: NetworkImage(
//               results[index]['image'],
//             ),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//               Theme.of(context).primaryColorLight,
//               BlendMode.darken,
//             ),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             '${results[index]['category']}',
//             style: TextStyle(
//               color: Theme.of(context).primaryColor,
//               fontSize: 36.0,
//             ),
//             textAlign: TextAlign.center,
//             strutStyle: StrutStyle(
//               fontSize: 16.0,
//               height: 3.0,
//             ),
//           ),
//         ),
//         // margin:
//         // index.isEven
//         // ? EdgeInsets.only(bottom: 10.0, left: 50.0)
//         // :
//         // EdgeInsets.only(right: 50.0, left: 50.0),
//         // decoration: BoxDecoration(
//         //   borderRadius: BorderRadius.horizontal(
//         //     left: Radius.circular(50.0),
//         //   ),
//         //   // boxShadow: [
//         //   //   BoxShadow(
//         //   //     blurRadius: 10.0,
//         //   //     color: Theme.of(context).primaryColorLight,
//         //   //     // spreadRadius: 50.0
//         //   //   )
//         //   // ],
//         // ),
//         // margin: EdgeInsets.all(0.0),
//         // child: Stack(
//         //   // index: index,
//         //   fit: StackFit.expand,
//         //   children: <Widget>[
//         //     // ClipRRect(
//         //       // borderRadius: BorderRadius.only(
//         //       // bottomRight: Radius.circular(150.0),
//         //       // topRight: Radius.circular(150.0),
//         //       // bottomLeft: Radius.circular(150.0),
//         //       // topLeft: Radius.circular(150.0),
//         //       // ),
//         //       // borderRadius: BorderRadius.circular(20.0),
//         //       // index.isEven
//         //       //     ?
//         //       //     BorderRadius.only(
//         //       //   bottomLeft: Radius.circular(100.0),
//         //       //   topRight: Radius.circular(100.0),
//         //       // ),
//         //       // : BorderRadius.only(
//         //       //     bottomRight: Radius.circular(100.0),
//         //       //     topLeft: Radius.circular(100.0),
//         //       //   ),
//         //       // borderRadius: BorderRadius.circular(100.0),
//         //       // child:
//         //       Hero(
//         //         tag: results[index]['category'],
//         //         child: Image.network(
//         //           results[index]['image'],
//         //           fit: BoxFit.cover,
//         //           colorBlendMode: BlendMode.darken,
//         //           color: Theme.of(context).primaryColorLight,
//         //         ),
//         //       ),
//         //     // ),
//         //     Align(
//         //       alignment: Alignment.center,
//         //       child: Text(
//         //         '${results[index]['category']}',
//         //         style: TextStyle(
//         //           color: Theme.of(context).primaryColor,
//         //           fontSize: 36.0,
//         //         ),
//         //         textAlign: TextAlign.center,
//         //         strutStyle: StrutStyle(
//         //           fontSize: 16.0,
//         //           height: 3.0,
//         //         ),
//         //       ),
//         //     )
//         //   ],
//         // ),
//         //   ),
//         // );
//         // },
//       ),
//     ),
//   );
// }
// ],
// ),
// );
//     } else {
//       return Offline();
//     }
//   },
// );

// : ListView.builder(
//     itemCount: results.length,
//     // addAutomaticKeepAlives: true,
//     padding: EdgeInsets.all(0.0),
//     itemBuilder: (BuildContext context, int index) {
//       return GestureDetector(
//         onTap: () {
//           PageController _pageController =
//               new PageController(initialPage: index);
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => PageView.builder(
//                     controller: _pageController,
//                     itemCount: results.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       // _pageController.animateToPage(index,
//                       //     duration: Duration(milliseconds: 500));
//                       return ListProducts(
//                           results[index]['category'],
//                           results[index]['image']);
//                     },
//                   )));
//         },
//         child: Container(
//           height: 200.0,
//           margin: EdgeInsets.all(0.0),
//           padding: EdgeInsets.all(0.0),
//           child: Container(
//             // margin: EdgeInsets.only(bottom: 10.0),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   results[index]['image'],
//                 ),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Theme.of(context).primaryColorLight,
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//             // child: Hero(
//             //   tag: '${results[index]['category']}',
//             //   child: Image.network(
//             //     results[index]['image'],
//             //     fit: BoxFit.cover,
//             //     colorBlendMode: BlendMode.hardLight,
//             //     color: Theme.of(context).primaryColorLight,
//             //   ),
//             // ),
//             child: Center(
//               child: Text(
//                 results[index]['category'].toString().toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 30.0,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding:
//           //       const EdgeInsets.only(top: 80.0, left: 10.0),
//           //   child: Text(
//           //     results[index]['category']
//           //         .toString()
//           //         .toUpperCase(),
//           //     style: TextStyle(
//           //       fontSize: 24.0,
//           //       color: Theme.of(context).primaryColor,
//           //     ),
//           //     textAlign: TextAlign.start,
//           //   ),
//           // ),
//         ),
//       );
//     }));

// ));
//   }
// }

// return Container(
//   height: 200.0,
//   margin: EdgeInsets.only(left: 80.0, bottom: 10.0),
//   decoration: BoxDecoration(
//     image: DecorationImage(
//       image: NetworkImage(
//         results[index]['image'],
//       ),
//       fit: BoxFit.cover,
//       colorFilter: ColorFilter.mode(
//         Theme.of(context).primaryColorLight,
//         BlendMode.darken,
//       ),
//     ),
//   ),
//   child: Padding(
//     padding: const EdgeInsets.only(top: 80.0),
//     child: Text(
//       results[index]['category'].toString().toUpperCase(),
//       style: TextStyle(
//         fontSize: 30.0,
//         color: Theme.of(context).primaryColor,
//       ),
//       textAlign: TextAlign.left,
//     ),
//   ),
// );
// },
// )
// : GridView.builder(
//     itemCount: results.length,
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       crossAxisSpacing: 5.0,
//       mainAxisSpacing: 5.0,
//       childAspectRatio: 0.6,
//     ),
//     padding: EdgeInsets.all(10.0),
//     itemBuilder: (BuildContext context, int index) {
//       return GestureDetector(
//         onTap: () {
//           // Navigator.of(context).push(
//           //   PageTransition(
//           //     child: ListProducts(
//           //       results[index]['category'],
//           //     ),
//           //     type: PageTransitionType.rightToLeftWithFade,
//           //     duration: Duration(milliseconds: 400),
//           //   ),
//           // );
//           PageController _pageController =
//               new PageController(initialPage: index);
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => PageView.builder(
//                     controller: _pageController,
//                     itemCount: results.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       // _pageController.animateToPage(index,
//                       //     duration: Duration(milliseconds: 500));
//                       return ListProducts(
//                           results[index]['category'],
//                           results[index]['image']);
//                     },
//                   )));
//           // return PageView.builder(
//           //   itemCount: results.length,
//           //   itemBuilder: (BuildContext context, int index) {
//           //     return ListProducts(results[index]['category']);
//           //   },
//           // );
//         },
//         child: Container(
//           margin: EdgeInsets.only(top: 5.0, left: 1.0, right: 1.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//             color: Theme.of(context).primaryColorDark,
//             image: DecorationImage(
//               image: NetworkImage(
//                 results[index]['image'],
//               ),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                 Theme.of(context).primaryColorLight,
//                 BlendMode.hardLight,
//               ),
//             ),
//           ),
//           child: Center(
//             child: Text(
//               results[index]['category'].toString(),
//               style: TextStyle(
//                 fontSize: 30.0,
//                 color: Theme.of(context).primaryColor,
//               ),
//               textAlign: TextAlign.center,
//               strutStyle: StrutStyle(
//                 // fontSize: 16.0,
//                 height: 3.0,
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   )
// StreamBuilder(
//   stream: _cloudFirestore.collection('Category').snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       // return Container(
//       //   child: FlareAnimation().flareActor(),
//       //   // color: Theme.of(context).primaryColor,
//       //   height: 70.0,
//       // );
//       return Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(
//               Theme.of(context).primaryColorDark),
//         ),
//       );
//     } else {
//       if (snapshot.hasData) {
//         if (snapshot.data.documents.length == 0) {
//           return Center(
//             child: Text(
//               'No Category Present',
//               style: TextStyle(
//                   color: Theme.of(context).accentColor, fontSize: 24.0),
//             ),
//           );
//         } else {
//           return GridView.builder(
//             itemCount: snapshot.data.documents.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 5.0,
//               mainAxisSpacing: 5.0,
//               childAspectRatio: 0.6,
//             ),
//             padding:
//                 EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 // child: Container(
//                 //   margin:
//                 //       EdgeInsets.only(top: 5.0, left: 1.0, right: 1.0),
//                 //   decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(20.0),
//                 //     color: Colors.black,
//                 //   ),
//                 child: Container(
//                   margin:
//                       EdgeInsets.only(top: 5.0, left: 1.0, right: 1.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: Theme.of(context).primaryColorDark,
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           snapshot.data.documents[index]['image']),
//                       fit: BoxFit.cover,
//                       colorFilter: ColorFilter.mode(
//                         Theme.of(context).primaryColorLight,
//                         BlendMode.hardLight,
//                       ),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       snapshot.data.documents[index]['category']
//                           .toString(),
//                       style: TextStyle(
//                         fontSize: 30.0,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       textAlign: TextAlign.center,
//                       strutStyle: StrutStyle(
//                         // fontSize: 16.0,
//                         height: 3.0,
//                       ),
//                     ),
//                   ),
//                   // child: Stack(
//                   //   fit: StackFit.expand,
//                   //   children: <Widget>[
//                   //     ClipRRect(
//                   //       borderRadius: BorderRadius.circular(20.0),
//                   //       child: FadeInImage(
//                   //         placeholder: AssetImage(
//                   //           'assets/images/product/image 7.png',
//                   //         ),
//                   //         image: image,
//                   //         fit: BoxFit.fitHeight,
//                   //       ),
//                   //     ),
//                   //     Center(
//                   //       child: Text(
//                   //         snapshot.data.documents[index]['category'],
//                   //         style: TextStyle(
//                   //           fontSize: 30.0,
//                   //           color: Theme.of(context).primaryColor,
//                   //         ),
//                   //         textAlign: TextAlign.center,
//                   //         strutStyle: StrutStyle(
//                   //           // fontSize: 16.0,
//                   //           height: 3.0,
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                 ),
//                 // ),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     PageTransition(
//                       child: ListProducts(
//                         snapshot.data.documents[index]['category'],
//                       ),
//                       type: PageTransitionType.rightToLeftWithFade,
//                       duration: Duration(milliseconds: 400),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//           // _tabcontroller = TabController(
//           //     vsync: this, length: snapshot.data.documents.length);
//           // return DefaultTabController(
//           //   length: snapshot.data.documents.length,
//           //   initialIndex: _tabopen,
//           //   child: Scaffold(
//           //     key: _scaffoldState,
//           //     appBar: AppBar(
//           //       // backgroundColor: Theme.of(context).accentColor,
//           //       bottom: TabBar(
//           //         // controller: _tabcontroller,
//           //         indicator: BoxDecoration(
//           //           borderRadius: BorderRadius.circular(30.0),
//           //           // border: Border.all(color: Theme.of(context).accentColor),
//           //           color: Theme.of(context).accentColor,
//           //           // shape: BoxShape.c
//           //         ),
//           //         indicatorSize: TabBarIndicatorSize.tab,
//           //         isScrollable: true,
//           //         labelColor: Theme.of(context).primaryColor,
//           //         labelStyle: TextStyle(
//           //           fontSize: 22.0,
//           //           // color: Theme.of(context).primaryColor,
//           //           // fontWeight: FontWeight.w600,
//           //           fontFamily: 'Gotham Light',
//           //         ),
//           //         unselectedLabelColor: Theme.of(context).accentColor,
//           //         unselectedLabelStyle: TextStyle(
//           //           fontSize: 18.0,
//           //           fontFamily: 'Gotham Light',
//           //         ),
//           //         tabs: [
//           //           // Tab(icon: Icon(Icons.directions_car)),
//           //           // Tab(icon: Icon(Icons.directions_transit)),
//           //           // Tab(icon: Icon(Icons.directions_bike)),

//           //           for (var i = 0; i < snapshot.data.documents.length; i++)
//           //             Tab(
//           //               child: Text(
//           //                 snapshot.data.documents[i]['category'],
//           //                 // style: TextStyle(fontSize: 18.0),
//           //               ),
//           //             ),
//           //         ],
//           //       ),
//           //       title: Text(
//           //         'Sai Collection',
//           //         style: TextStyle(
//           //             color: Theme.of(context).accentColor,
//           //             fontSize: 24.0,
//           //             fontWeight: FontWeight.w600),
//           //       ),
//           //       // elevation: 5.0,
//           //     ),
//           //     body: TabBarView(
//           //       // controller: _tabcontroller,
//           //       children: <Widget>[
//           //         for (var i = 0; i < snapshot.data.documents.length; i++)
//           //           // Center(
//           //           //   child: Text(
//           //           //     _products[i],
//           //           //     style: TextStyle(color: Colors.green),
//           //           //   ),
//           //           // )
//           //           ListProducts(snapshot.data.documents[i]['category'])
//           //       ],
//           //     ),
//           //     drawer: DrawerHome()
//           //         .drawer(context, _mobileNumber, _scaffoldState),
//           //   ),
//           // );
//         }
//       }
//     }
//     return SizedBox();
//   },
// ),
// );

// return FutureBuilder(
//   future: getCategories(),
//   builder: (BuildContext context, AsyncSnapshot<dynamic> categories) {
//     // return SizedBox();
//     if (categories.connectionState == ConnectionState.waiting) {
//       return Container(
//         child: FlareAnimation().flareActor(),
//         color: Theme.of(context).primaryColor,
//       );
//     } else if (categories.connectionState == ConnectionState.done) {
//       print('AsyncSnapshot ${categories.data}');
//       List<String> _products = [];
//       for (var item in categories.data) {
//         print('Categories are : ${item.data['category']}');
//         _products.add(item.data['category']);
//       }
//       return DefaultTabController(
//         length: _products.length,
//         // initialIndex: 0,
//         child: Scaffold(
//           key: _scaffoldState,
//           appBar: AppBar(
//             // backgroundColor: Theme.of(context).accentColor,
//             bottom: TabBar(
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30.0),
//                 // border: Border.all(color: Theme.of(context).accentColor),
//                 color: Theme.of(context).accentColor,
//                 // shape: BoxShape.c
//               ),
//               indicatorSize: TabBarIndicatorSize.tab,
//               isScrollable: true,
//               labelColor: Theme.of(context).primaryColor,
//               unselectedLabelColor: Theme.of(context).accentColor,
//               tabs: [
//                 // Tab(icon: Icon(Icons.directions_car)),
//                 // Tab(icon: Icon(Icons.directions_transit)),
//                 // Tab(icon: Icon(Icons.directions_bike)),

//                 for (var i = 0; i < _products.length; i++)
//                   Tab(
//                     child: Text(
//                       _products[i],
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                   ),
//               ],
//             ),
//             title: Text(
//               'Sai Collection',
//               style: TextStyle(
//                   color: Theme.of(context).accentColor,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w600),
//             ),
//             // elevation: 5.0,
//           ),
//           body: TabBarView(
//             children: <Widget>[
//               for (var i = 0; i < _products.length; i++)
//                 // Center(
//                 //   child: Text(
//                 //     _products[i],
//                 //     style: TextStyle(color: Colors.green),
//                 //   ),
//                 // )
//                 ListProducts(_products[i])
//             ],
//           ),
//           drawer: DrawerHome().drawer(context, _mobileNumber, _scaffoldState),
//         ),
//       );
//     }
//     return SizedBox();
//   },
// );
// }

// @override
// bool get wantKeepAlive => true;

// @override
// void dispose() {
//   print('Dispose Called');
//   super.dispose();
// }
// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   print('state = $state');
// }
// }

// child: Scaffold(
//         key: _scaffoldState,
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           iconTheme: IconThemeData(
//             color: Theme.of(context).accentColor,
//           ),
//           title: Text(
//             'Sai Collection',
//             style: TextStyle(
//               color: Theme.of(context).accentColor,
//               // fontFamily: 'Righteous',
//               fontWeight: FontWeight.w600,
//               letterSpacing: 1.2,
//             ),
//           ),
//           elevation: 0.0,
// bottom: PreferredSize(
//   child: Container(
//     margin: const EdgeInsets.symmetric(horizontal: 10.0),
//     color: Theme.of(context).accentColor,
//     height: 0.5,
//   ),
//   preferredSize: Size.fromHeight(0.0),
// ),
//         ),
//         body: OfflineBuilder(
//             child: SizedBox(),
//             connectivityBuilder: (BuildContext context,
//                 ConnectivityResult connectivity, Widget child) {
//               final bool connected = connectivity != ConnectivityResult.none;
//               if (connected) {
//                 return FutureBuilder(
//                   future: getCategories(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<dynamic> categories) {
//                     // return SizedBox();
//                     if (categories.connectionState == ConnectionState.waiting) {
//                       return Center(
//                         child: Container(
//                           height: 70.0,
//                           child: FlareAnimation().flareActor(
//                             Theme.of(context).accentColor,
//                           ),
//                         ),
//                       );
//                     } else if (categories.connectionState ==
//                         ConnectionState.done) {
//                       print('AsyncSnapshot ${categories.data}');
//                       List<String> _products = [];
//                       for (var item in categories.data) {
//                         print('Categories are : ${item.data['category']}');
//                         _products.add(item.data['category']);
//                       }
//                       return ListView.builder(
//                         itemCount: _products.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                             child: Container(
//                               height: 250.0,
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 30.0, vertical: 20.0),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Theme.of(context).accentColor),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 // image: DecorationImage(
//                                 //   colorFilter: ColorFilter.mode(
//                                 //       Colors.black.withOpacity(0.4),
//                                 //       BlendMode.darken),
//                                 //   image: AssetImage(
//                                 //     ImageGenerator()
//                                 //         .generateRandomProductImage(),
//                                 //   ),
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                                 // boxShadow: [
//                                 //   BoxShadow(
//                                 //       blurRadius: 10.0,
//                                 //       color: Theme.of(context).accentColor,
//                                 //       spreadRadius: 7.0),
//                                 // ]
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   _products[index],
//                                   style: TextStyle(
//                                     color: Theme.of(context).accentColor,
//                                     fontSize: 35.0,
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 PageTransition(
//                                   child: ListProducts(_products[index]),
//                                   type: PageTransitionType.rightToLeftWithFade,
//                                   duration: Duration(milliseconds: 500),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       );
//                     }
//                     return SizedBox();
//                   },
//                 );
//               } else {
//                 return Center(
//                   child: Text(
//                     'No Internet Connection 😴',
//                     style: TextStyle(
//                         color: Theme.of(context).accentColor, fontSize: 20.0),
//                   ),
//                 );
//               }
//             }),
//         // }),
//         // appBar: AppBar(
//         //   iconTheme: IconThemeData(color: Theme.of(context).accentColor),
//         //   title: Text(
//         //     'Sai Collection',
//         //     // style: TextStyle(fontFamily: 'PermanentMarker',letterSpacing: 1.5, fontSize: 25.0),
//         //     style: TextStyle(
//         //         fontFamily: 'Righteous',
//         //         letterSpacing: 1.5,
//         //         fontSize: 25.0,
//         //         color: Theme.of(context).accentColor),
//         //   ),
//         //   backgroundColor: Theme.of(context).accentColor,
//         //   bottom: PreferredSize(
//         //     child: Container(
//         //       margin: const EdgeInsets.symmetric(horizontal: 5.0),
//         //       color: Theme.of(context).accentColor,
//         //       height: 2.0,
//         //     ),
//         //     preferredSize: Size.fromHeight(0.0),
//         //   ),
//         // ),
//         // appBar: AppBarCreate().appbarCreate(context, 'Sai Collection'),
//         drawer: DrawerHome().drawer(context, _mobileNumber, _scaffoldState),
//       ),
