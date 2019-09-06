import 'package:flutter/material.dart';
//
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
//
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Home/Product/product_details.dart';

class ListProducts extends StatefulWidget {
  final _category, _imageurl;
  // final _category;
  // ListProducts(this._category);
  ListProducts(this._category, this._imageurl);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  // final _cloudFirestore = Firestore();
  // final _cloudFunction = CloudFunctions.instance;
  var query;
  String sizeOfProduct;

  @override
  void initState() {
    super.initState();
    // if (_results.isEmpty) {
    // getProductData();
    // }
    print('init state');
    query = SharedP.firestore.collection(widget._category).snapshots();
    // query = _cloudFirestore.collection('testing').snapshots();
    // refresh = true;
  }

  // getProductData() async {
  //   _cloudFunction
  //       .getHttpsCallable(functionName: 'getProductsOfCategory')
  //       .call({'category': widget._category}).then((data) {
  //     _results = data.data;
  //     // resultFetch = true;
  //     setState(() {});
  //     print('Results are $_results');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrollin) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              centerTitle: true,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              elevation: 5.0,
              flexibleSpace: FlexibleSpaceBar(
                // titlePadding: EdgeInsets.only(top: 80),
                centerTitle: true,
                title: Text(
                  widget._category.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24.0,
                  ),
                ),
                background: Hero(
                  tag: widget._category.toString(),
                  // child: Image.network(
                  //   widget._imageurl,
                  //   fit: BoxFit.cover,
                  //   color: Colors.black.withOpacity(0.3),
                  //   colorBlendMode: BlendMode.darken,
                  //   // color: Theme.of(context).primaryColorDark,
                  // ),
                  child: Image(
                    image: CachedNetworkImageProvider(widget._imageurl),
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Text(
                        'Filter',
                      ),
                      splashColor: Theme.of(context).primaryColorDark,
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColorDark),
                      padding: EdgeInsets.all(5.0),
                      textColor: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        query = SharedP.firestore
                            .collection(widget._category)
                            .snapshots();
                        setState(() {});
                      },
                      child: Text(
                        'Clear Filter',
                        // style: TextStyle(
                        //     color: Theme.of(context).primaryColorDark),
                      ),
                      splashColor: Theme.of(context).primaryColorDark,
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColorDark),
                      padding: EdgeInsets.all(5.0),
                      textColor: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                // key: PageStorageKey(widget._category),
                // stream: _cloudFirestore
                //     .collection(widget._category)
                //     // .where("Discount Price", isGreaterThan: "500")
                //     // .orderBy('Discount Price', descending: true)
                //     .snapshots(),
                // stream: _cloudFirestore.collection(widget._category).where('Discount Price', isGreaterThan: 300).snapshots(),
                stream: query,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // _cloudFirestore.collection(widget._category).where('Discount Price', isGreaterThan: 100).snapshots();

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
                        // } else {

                        // }
                      } else {
                        // print('data before ${snapshot.data.documents}');
                        // List data = snapshot.data.documents;
                        // print('data before $data');
                        // if (refresh) {
                        //   data.shuffle();
                        //   refresh = false;
                        // }
                        // print("data is $data");
                        List data = snapshot.data.documents;
                        // if (refresh) {
                        //   data.shuffle();
                        // }
                        return GridView.builder(
                          key: PageStorageKey(widget._category),
                          itemCount: data.length,
                          // itemCount: snapshot.data.documents.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 5.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 0.65,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProductDetails(
                                      // snapshot.data.documents[index],
                                      snapshot.data.documents[index],
                                      widget._category,
                                      index.toString()
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Theme.of(context).primaryColorDark)
                                ),
                                elevation: 2.0,
                                margin: EdgeInsets.zero,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Hero(
                                        tag: index.toString(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10.0),
                                            ),
                                            color:
                                                Theme.of(context).accentColor,
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  snapshot
                                                      .data
                                                      .documents[index]
                                                          ['Images']
                                                      .first),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(left: 10.0),
                                    //   child: Text(
                                    //     // '${snapshot.data.documents[index]['Name Of Brand']}',
                                    //     '${data[index]['Name Of Brand']}',
                                    //     // .toUpperCase(),
                                    //     style: TextStyle(
                                    //       color: Theme.of(context)
                                    //           .primaryColorLight,
                                    //       fontWeight: FontWeight.w600,
                                    //       fontSize: 15.0,
                                    //     ),
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 5.0,
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        // '${snapshot.data.documents[index]['Name Of Product']}',
                                        '${data[index]['Name Of Product']}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          '\u20B9',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                        SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          // '${snapshot.data.documents[index]['Discount Price']}',
                                          '${data[index]['Discount Price']}',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          // '${snapshot.data.documents[index]['Original Price']}',
                                          '${data[index]['Original Price']}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            // fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        builder: (BuildContext buildContext) {
          return Container(
            height: 100.0,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sort :',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColorDark
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          _priceModal(context);
                        },
                        child: Text(
                          'Price',
                        ),
                        splashColor: Theme.of(context).primaryColorDark,
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(5.0),
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          _discountModal(context);
                        },
                        child: Text(
                          'Discount',
                        ),
                        splashColor: Theme.of(context).primaryColorDark,
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(5.0),
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _priceModal(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        builder: (BuildContext buildContext) {
          return Container(
            height: 100.0,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Price :',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColorDark
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          query = SharedP.firestore
                              .collection(widget._category)
                              .where('Size', isEqualTo: sizeOfProduct)
                              .orderBy('Discount Price', descending: false)
                              .snapshots();
                          setState(() {});
                        },
                        child: Text(
                          'Low To High',
                        ),
                        splashColor: Theme.of(context).primaryColorDark,
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(5.0),
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          query = SharedP.firestore
                              .collection(widget._category)
                              .where('Size', isEqualTo: sizeOfProduct)
                              .orderBy('Discount Price', descending: true)
                              .snapshots();
                          setState(() {});
                        },
                        child: Text(
                          'High To Low',
                        ),
                        splashColor: Theme.of(context).primaryColorDark,
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(5.0),
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     OutlineButton(
                //       onPressed: () {
                //       },
                //       child: Text(
                //         'Low to High',
                //       ),
                //       splashColor: Theme.of(context).primaryColorDark,
                //       borderSide:
                //           BorderSide(color: Theme.of(context).primaryColorDark),
                //       padding: EdgeInsets.all(10.0),
                //       textColor: Theme.of(context).primaryColorDark,
                //     ),
                //     OutlineButton(
                //       onPressed: () {

                //       },
                //       child: Text(
                //         'High to Low',
                //       ),
                //       splashColor: Theme.of(context).primaryColorDark,
                //       borderSide:
                //           BorderSide(color: Theme.of(context).primaryColorDark),
                //       padding: EdgeInsets.all(10.0),
                //       textColor: Theme.of(context).primaryColorDark,
                //     ),
                //   ],
                // )
              ],
            ),
          );
        });
  }

  // set Size Query
  void setSizeQuery(String size) {
    Navigator.of(context).pop();
    sizeOfProduct = size;
    query = SharedP.firestore
        .collection(widget._category)
        .where('Size', isEqualTo: size)
        .snapshots();
    setState(() {});
  }

  void _discountModal(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        builder: (BuildContext buildContext) {
          return Container(
            height: 100.0,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Discount :',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColorDark
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          // if (sizeOfProduct.isNotEmpty) {
                          // String h;
                          query = SharedP.firestore
                              .collection(widget._category)
                              .where('Discount', isLessThanOrEqualTo: 50)
                              .where('Size', isEqualTo: sizeOfProduct)
                              .snapshots();
                          // } else {}
                          setState(() {});
                        },
                        child: Text(
                          '< 50 %',
                        ),
                        splashColor: Theme.of(context).primaryColorDark,
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(10.0),
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          query = SharedP.firestore
                              .collection(widget._category)
                              .where('Discount', isGreaterThanOrEqualTo: 50)
                              .where('Size', isEqualTo: sizeOfProduct)
                              .snapshots();
                          setState(() {});
                        },
                        child: Text(
                          '> 50 %',
                        ),
                        splashColor: Theme.of(context).primaryColorDark,
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(10.0),
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

//  ! Junk code --

// void _sizeModal(context) {
//   List<String> sizeForProducts = ['L', 'M', 'XL', 'XXL'];
//   List<String> sizeForJeans = ['28', '30', '32', '34', '36'];
//   showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//       ),
//       builder: (BuildContext buildContext) {
//         return Container(
//           height: 100.0,
//           margin: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Size :',
//                 style: TextStyle(
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.w600,
//                   // color: Theme.of(context).primaryColorDark
//                 ),
//               ),
//               (widget._category == 'Jeans' || widget._category == 'Trousers')
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         for (int i = 0; i < sizeForJeans.length; i++)
//                           FloatingActionButton(
//                             onPressed: () {
//                               setSizeQuery(sizeForJeans[i]);
//                             },
//                             child: Text(
//                               sizeForJeans[i],
//                               style: TextStyle(
//                                   color: Theme.of(context).primaryColor),
//                             ),
//                             elevation: 0.0,
//                             mini: true,
//                             backgroundColor:
//                                 Theme.of(context).primaryColorDark,
//                           ),
//                       ],
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         for (int i = 0; i < sizeForProducts.length; i++)
//                           FloatingActionButton(
//                             onPressed: () {
//                               setSizeQuery(sizeForProducts[i]);
//                             },
//                             child: Text(
//                               sizeForProducts[i],
//                               style: TextStyle(
//                                   color: Theme.of(context).primaryColor),
//                             ),
//                             elevation: 0.0,
//                             mini: true,
//                             backgroundColor:
//                                 Theme.of(context).primaryColorDark,
//                           ),
//                       ],
//                     )
//             ],
//           ),
//         );
//       });
// }

// FloatingActionButton(
//   onPressed: () {
//     // sizeOfProduct = 'L';
//     // query = _cloudFirestore
//     //     .collection(widget._category)
//     //     .where('Size', isEqualTo: sizeOfProduct)
//     //     .snapshots();
//     // Navigator.of(context).pop();
//     // setState(() {});
//     setSizeQuery('L');
//   },
//   child: Text(
//     'L',
//     style: TextStyle(color: Theme.of(context).primaryColor),
//   ),
//   elevation: 0.0,
//   mini: true,
//   backgroundColor: Theme.of(context).primaryColorDark,
// ),
// FloatingActionButton(
//   onPressed: () {
//     setSizeQuery('M');
//   },
//   child: Text(
//     'M',
//     style: TextStyle(color: Theme.of(context).primaryColor),
//   ),
//   elevation: 0.0,
//   mini: true,
//   backgroundColor: Theme.of(context).primaryColorDark,
// ),
// FloatingActionButton(
//   onPressed: () {
//     setSizeQuery('XL');
//   },
//   child: Text(
//     'XL',
//     style: TextStyle(color: Theme.of(context).primaryColor),
//   ),
//   elevation: 0.0,
//   mini: true,
//   backgroundColor: Theme.of(context).primaryColorDark,
// ),
// FloatingActionButton(
//   onPressed: () {
//     setSizeQuery('XXL');
//   },
//   child: Text(
//     'XXL',
//     style: TextStyle(color: Theme.of(context).primaryColor),
//   ),
//   elevation: 0.0,
//   mini: true,
//   backgroundColor: Theme.of(context).primaryColorDark,
// ),
// Center(
//   child: RaisedButton(
//     onPressed: () {
//       print('descending $descending');
//       print('discount percentage $discount_percentage');
//       // if (descending != null && discount_percentage != null) {
//       // if (descending != null) {
//       //   query = _cloudFirestore
//       //       .collection(widget._category)
//       //       .orderBy('Discount Price', descending: descending)
//       //       .where('Discount',
//       //           isGreaterThan: discount_percentage)
//       //       .snapshots();
//       // } else {
//       // Navigator.of(context).pop();
//       //   query = _cloudFirestore
//       //       .collection(widget._category)
//       //       .where('Discount',
//       //           isGreaterThan: discount_percentage)
//       //       .snapshots();
//       // }
//       Navigator.of(context).pop();
//       if (descending != null && discount_percentage != null) {
//         query = _cloudFirestore
//             .collection(widget._category)
//             .where('Discount',
//                 isGreaterThan: discount_percentage)
//             .orderBy('Discount')
//             .orderBy('Discount Price', descending: descending)
//             .snapshots();
//       } else if (descending != null &&
//           discount_percentage == null) {
//         query = _cloudFirestore
//             .collection(widget._category)
//             .orderBy('Discount Price', descending: descending)
//             .snapshots();
//       } else if (discount_percentage != null &&
//           descending == null) {
//         query = _cloudFirestore
//             .collection(widget._category)
//             .where('Discount',
//                 isGreaterThan: discount_percentage)
//             .snapshots();
//       }
//       setState(() {});
//       // } else {}
//     },
//     child: Text('Apply'),
//     textColor: Theme.of(context).primaryColor,
//   ),
// ),
// body: _results == null
//     ? Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(
//               Theme.of(context).primaryColorDark),
//         ),
//       )
//     : _results.isEmpty
//         ? Center(
//             child: Text(
//               'No Product Present 😞',
//               style: TextStyle(
//                   color: Theme.of(context).accentColor, fontSize: 24.0),
//             ),
//           )
//         : Column(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 7.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: OutlineButton(
//                   onPressed: () {
//                     _settingModalBottomSheet(context);
//                   },
//                   padding: EdgeInsets.all(5.0),
//                   child: Text('Filter',
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         color: Theme.of(context).primaryColorDark,
//                       )),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   borderSide: BorderSide(
//                       color: Theme.of(context).primaryColorDark),
//                   // splashColor: Theme.of(context).primaryColorDark,
//                 ),
//               ),
//               // SizedBox(
//               //   height: 7.0,
//               // ),
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: _results.length,
//                   gridDelegate:
//                       SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 0.0,
//                     mainAxisSpacing: 1.0,
//                     childAspectRatio: 0.6,
//                   ),
//                   // padding: EdgeInsets.symmetric(horizontal: 5.0),
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 ProductDetails(
//                               _results[index],
//                               widget._category,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                           // side: BorderSide(color: Theme.of(context).primaryColorDark)
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Expanded(
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.vertical(
//                                     top: Radius.circular(15.0),
//                                   ),
//                                   child: FadeInImage(
//                                     placeholder: AssetImage(
//                                         'assets/images/happy.png'),
//                                     image: NetworkImage(_results[index]
//                                             ['Images']
//                                         .first),
//                                     fit: BoxFit.cover,
//                                     fadeInDuration:
//                                         Duration(milliseconds: 500),
//                                     fadeOutDuration:
//                                         Duration(milliseconds: 500),
//                                   )
//                                   // Image.network(
//                                   //   _results[index]['Images'].first,
//                                   //   fit: BoxFit.cover,
//                                   // ),
//                                   ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10.0, bottom: 5.0, top: 3.0),
//                               child: Text(
//                                 '${_results[index]['Name Of Brand']}',
//                                 style: TextStyle(
//                                   color: Theme.of(context).accentColor,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 22.0,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10.0, bottom: 5.0, top: 3.0),
//                               child: Text(
//                                 '${_results[index]['Name Of Product']} ',
//                                 style: TextStyle(
//                                   color: Theme.of(context).accentColor,
//                                   fontSize: 18.0,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10.0, bottom: 5.0, top: 3.0),
//                               child: Row(
//                                 children: <Widget>[
//                                   Text(
//                                     '\u20B9',
//                                     style: TextStyle(
//                                       fontSize: 18.0,
//                                       color:
//                                           Theme.of(context).accentColor,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 2.0,
//                                   ),
//                                   Text(
//                                     _results[index]['Discount Price'],
//                                     style: TextStyle(
//                                         fontSize: 15.0,
//                                         color: Theme.of(context)
//                                             .accentColor),
//                                   ),
//                                   SizedBox(
//                                     width: 5.0,
//                                   ),
//                                   Text(
//                                     _results[index]['Original Price'],
//                                     style: TextStyle(
//                                       fontSize: 15.0,
//                                       // fontWeight: FontWeight.w600,
//                                       color:
//                                           Theme.of(context).accentColor,
//                                       decoration:
//                                           TextDecoration.lineThrough,
//                                       decorationThickness: 2.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),

// child: Container(
//   margin:
//       EdgeInsets.only(top: 5.0, left: 1.0, right: 1.0),
//   // color: Theme.of(context).primaryColorDark,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(20.0),
//     // border: Border.all(
//     //     color: Theme.of(context).accentColor),
//     color: Theme.of(context).accentColor,
//     image: DecorationImage(
//       image:
//           NetworkImage(_results[index]['Images'].first),
//       fit: BoxFit.cover,
//       alignment: Alignment.center,
//       colorFilter: ColorFilter.mode(
//         Color.fromRGBO(00, 00, 00, 0.5),
//         BlendMode.darken,
//       ),
//     ),
//   ),
// ),

// StreamBuilder(
//   stream: _cloudFirestore.collection(widget._category).snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     print('Stream Builder Called');
//     // return StaggeredShimmer().showStaggeredShimmer(context, 4, 16);
//     // } else {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(
//               Theme.of(context).primaryColorDark),
//         ),
//       );
//       // print('Connection done');
//     } else {
//       if (snapshot.hasData) {
//         if (snapshot.data.documents.length == 0) {
//           return Center(
//             child: Text(
//               'No Product Present 😞',
//               style: TextStyle(
//                   color: Theme.of(context).accentColor, fontSize: 24.0),
//             ),
//           );
//         } else {
//           return GridView.builder(
//             itemCount: snapshot.data.documents.length,
//             // itemCount: 16,
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
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                         child: ProductDetails(
//                             snapshot.data.documents[index],
//                             widget._category,
//                             snapshot.data.documents[index].documentID),
//                         type: PageTransitionType.rightToLeftWithFade,
//                         duration: Duration(milliseconds: 500)),
//                   ).then((v) {
//                     print('Value is $v');
//                   });
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => ContactUs()));
//                 },
//                 child: Container(
//                   margin:
//                       EdgeInsets.only(top: 5.0, left: 1.0, right: 1.0),
//                   // color: Theme.of(context).primaryColorDark,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     // border: Border.all(
//                     //     color: Theme.of(context).accentColor),
//                     color: Theme.of(context).accentColor,
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           snapshot.data.documents[index]['Images'].first),
//                       fit: BoxFit.cover,
//                       alignment: Alignment.center,
//                       colorFilter: ColorFilter.mode(
//                         Color.fromRGBO(00, 00, 00, 0.5),
//                         BlendMode.darken,
//                       ),
//                     ),
//                   ),
//                   // child: Column(
//                   //   mainAxisAlignment: MainAxisAlignment.end,
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: <Widget>[
//                   //     Padding(
//                   //       padding: const EdgeInsets.only(
//                   //           left: 10.0, bottom: 8.0),
//                   //       child: Text(
//                   //         snapshot.data.documents[index]['Name Of Brand'],
//                   //         style: TextStyle(
//                   //           color: Theme.of(context).primaryColor,
//                   //           fontWeight: FontWeight.w600,
//                   //           fontSize: 24.0,
//                   //         ),
//                   //         overflow: TextOverflow.ellipsis,
//                   //       ),
//                   //     ),
//                   //     Padding(
//                   //       padding:
//                   //           const EdgeInsets.only(left: 10.0, top: 8.0),
//                   //       child: Text(
//                   //         snapshot.data.documents[index]
//                   //             ['Name Of Product'],
//                   //         style: TextStyle(
//                   //             color: Theme.of(context).primaryColor,
//                   //             fontSize: 20.0),
//                   //         overflow: TextOverflow.ellipsis,
//                   //       ),
//                   //     ),
//                   //     Padding(
//                   //       padding:
//                   //           const EdgeInsets.only(left: 10.0, top: 8.0),
//                   //       child: Row(
//                   //         children: <Widget>[
//                   //           Text(
//                   //             '\u20B9',
//                   //             style: TextStyle(
//                   //               fontSize: 24.0,
//                   //               color: Theme.of(context).primaryColor,
//                   //             ),
//                   //           ),
//                   //           SizedBox(
//                   //             width: 5.0,
//                   //           ),
//                   //           Text(
//                   //             snapshot.data.documents[index]
//                   //                 ['Original Price'],
//                   //             style: TextStyle(
//                   //               fontSize: 20.0,
//                   //               // fontWeight: FontWeight.w600,
//                   //               color: Theme.of(context).primaryColor,
//                   //               decoration: TextDecoration.lineThrough,
//                   //               decorationThickness: 2.0,
//                   //             ),
//                   //           ),
//                   //           SizedBox(
//                   //             width: 10.0,
//                   //           ),
//                   //           Text(
//                   //             snapshot.data.documents[index]
//                   //                 ['Discount Price'],
//                   //             style: TextStyle(
//                   //                 fontSize: 20.0,
//                   //                 color: Theme.of(context).primaryColor),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ),
//                   //     SizedBox(
//                   //       height: 10.0,
//                   //     )
//                   //   ],
//                   // ),
//                   child: Center(
//                     child: Text(
//                       '$index',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 30.0),
//                     ),
//                   ),
//                 ),
//               );
//             },
//             // staggeredTileBuilder: (int index) =>
//             //     new StaggeredTile.count(2, 3.0),
//             // mainAxisSpacing: 4.0,
//             // crossAxisSpacing: 4.0,
//           );
//         }
//       }
//       // print('Hey there');
//       // return SizedBox();
//     }
//     return SizedBox();
//   },
// ),
