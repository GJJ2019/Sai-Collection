import 'package:flutter/material.dart';
//
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage, CachedNetworkImageProvider;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
import 'package:sai_collection/page_transition.dart';
import 'package:sai_collection/shared_p.dart';
import 'package:sai_collection/UI/Components/appbar.dart';
import 'package:sai_collection/UI/Components/generate_random.dart';
import 'package:sai_collection/UI/Components/show_dialog.dart';
import 'package:sai_collection/UI/Components/show_snack_bar.dart';
import 'package:sai_collection/UI/Home/Payment/payment.dart';

class ProductDetails extends StatefulWidget {
  // final _product, _category, _documentId;
  final _product, _category, _index;
  ProductDetails(this._product, this._category, this._index);
  // ProductDetails(this._product, this._category, this._documentId);
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // bool _loading = false;
  // SharedPreferences _preferences;
  String _mobileNumber, _name, _houseNo, _colony, _landmark, _selectedSize;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  List<String> _description, _featuresAndDetails;
  List<dynamic> _sizesOfProduct;

  @override
  void initState() {
    super.initState();
    // print('Product Details are ${widget._product}');
    // print('Document Id is ${widget._documentId}');
    // String a = widget._product['Description'].toString().trim();
    _description = widget._product['Description'].toString().split('.');
    // _description = a.split('.');
    _description.removeLast();
    _featuresAndDetails =
        widget._product['Features & Details'].toString().split('.');
    _featuresAndDetails.removeLast();
    _sizesOfProduct = widget._product['Size'];
    print('Description is $_description');
    print('Features & Details is $_featuresAndDetails');
    print('Sizes Of Products $_sizesOfProduct');
    // createSharedPreferences();
  }

  // createSharedPreferences() async {
  //   _preferences = await SharedPreferences.getInstance();
  // }

  String getDiscount() {
    // '(${(int.parse(widget.product['Discount Price']) * 100) / (int.parse(widget.product['Original Price']))} %)'
    int originalPrice = int.parse(widget._product['Original Price']);
    int discountPrice = int.parse(widget._product['Discount Price']);
    var discount = ((originalPrice - discountPrice) * 100) / originalPrice;
    return '${discount.floor().toString()} %';
  }

  // showAccountCompletionDialog(BuildContext context) {
  //   // String _smsCode;
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           // shape: RoundedRectangleBorder(
  //           //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //           // contentPadding: EdgeInsets.only(top: 10.0),
  //           title: Text(
  //             'Complete Your Profile 🙄 By Adding Name & Address',
  //             style: TextStyle(
  //                 fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
  //             textAlign: TextAlign.start,
  //           ),
  //           //   textAlign: TextAlign.center,
  //           // ),,
  //           content: Container(
  //             // width: 350.0,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 RaisedButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     // Navigator.push(context,
  //                     //     MaterialPageRoute(builder: (context) => Account()));
  //                     Navigator.of(context).push(
  //                       PageTransition(
  //                         builder: (context) => Account(),
  //                       ),
  //                     );
  //                   },
  //                   // padding: const EdgeInsets.symmetric(
  //                   //     horizontal: 30.0, vertical: 15.0),
  //                   child: Text(
  //                     'OK',
  //                     style: TextStyle(
  //                       color: Theme.of(context).primaryColor,
  //                       fontSize: 18.0,
  //                       letterSpacing: 1.5,
  //                     ),
  //                   ),
  //                   //   ),
  //                   // ),
  //                   // color: Theme.of(context).accentColor,
  //                   // shape: RoundedRectangleBorder(
  //                   //   borderRadius: BorderRadius.circular(20.0)
  //                   // )
  //                   // splashColor: Theme.of(context).accentColor,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // print('images are ${widget.product['Images']}');
    // print("""
    // Images are:
    // ${widget.product['Images'].map()}
    // """);
    // print('Mobile Number ${_mobileNumber}');
    return Scaffold(
      key: _scaffoldState,
      // backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBarCreate()
          .appbarCreate(context, widget._product['Name Of Brand']),
      body: Stack(
        children: <Widget>[
          // CarouselSlider(
          //   autoPlay: true,
          //   pauseAutoPlayOnTouch: Duration(seconds: 5),
          //   height: MediaQuery.of(context).size.height * 0.70,
          //   enlargeCenterPage: true,
          //   items: <Widget>[
          //     for (var i = 0; i < widget._product['Images'].length; i++)
          //       Container(
          //         // padding: EdgeInsets.all(20.0),
          //         margin: EdgeInsets.only(left: 5.0, top: 20.0),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //           border: Border.all(color: Theme.of(context).primaryColor),
          //         ),
          //         child: Hero(
          //           tag: '${widget._product['Name Of Product']}',
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //             child: FadeInImage(
          //               placeholder: AssetImage('assets/images/sad.png'),
          //               image: NetworkImage(
          //                 widget._product['Images'][i],
          //               ),
          //               fit: BoxFit.cover,
          //               fadeInDuration: Duration(milliseconds: 500),
          //               fadeOutDuration: Duration(milliseconds: 500),
          //             ),
          //             // child: Image.network(
          //             //   widget._product['Images'][i],
          //             //   fit: BoxFit.cover,
          //             // ),
          //           ),
          //         ),
          //       )
          //   ],
          // ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Carousel(
              autoplay: true,
              autoplayDuration: Duration(seconds: 4),
              showIndicator: false,
              // defaultImage: AssetImage('assets/images/sad.png'),
              // boxFit: BoxFit.fill,
              images: [
                for (var i = 0; i < widget._product['Images'].length; i++)
                  // Container(
                  // child: FadeInImage(
                  //   placeholder: AssetImage('assets/logo/nature.png'),
                  //   image: NetworkImage(
                  //     widget._product['Images'][i],
                  //   ),
                  //   fit: BoxFit.cover,
                  //   fadeInDuration: Duration(milliseconds: 500),
                  //   fadeOutDuration: Duration(milliseconds: 500),
                  // ),
                  // ),
                  Hero(
                    tag: widget._index,
                    child: CachedNetworkImage(
                    imageUrl: widget._product['Images'][i],
                    placeholder: (context, url) =>
                        Image.asset('assets/logo/nature.png'),
                    errorWidget: (context, url, error) =>
                        new Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  )
                // Container(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).accentColor,
                //     image: DecorationImage(
                //       image: CachedNetworkImageProvider(widget._product['Images'][i]),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // Hero(
                //   tag: '${widget._product['Name Of Product']}',
                //   child:
                // child: Image.network(
                //   widget._product['Images'][i],
                //   fit: BoxFit.cover,
                //   //   // fit: BoxFit.fill,
                // ),
                // ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.56),
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                    // side: BorderSide(color: Theme.of(context).primaryColorDark)
                  ),
                  margin: EdgeInsets.all(0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: GestureDetector(
                            child: Text(
                              'View Full Size Images',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  builder: (context) => PhotoGalleryForProduct(
                                      widget._product['Images']),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Brand : ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${widget._product['Name Of Brand']}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Product : ',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                '${widget._product['Name Of Product']}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Price : ',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    '\u20B9',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '${widget._product['Discount Price']}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.bold),
                                    // textAlign: TextAlign.right
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '${widget._product['Original Price']}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Theme.of(context).accentColor,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor:
                                          Theme.of(context).primaryColorLight,
                                      decorationThickness: 0.8,
                                    ),
                                  ),
                                ],
                              )
                              // SizedBox(
                              //   width: 15.0,
                              // ),
                              // Text(
                              //   '${getDiscount()} 😮',
                              //   style: TextStyle(
                              //     fontSize: 18.0,
                              //     color: Colors.green,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Discount : ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                // textAlign: TextAlign.start,
                              ),
                              Text(
                                // getDiscount(),
                                '${widget._product['Discount']} %  😄',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            'Size : ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                            // textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            for (int i = 0; i < _sizesOfProduct.length; i++)
                              ChoiceChip(
                                label: Text(
                                  '${_sizesOfProduct[i]}',
                                ),
                                selected: _selectedSize ==
                                    _sizesOfProduct[i].toString(),
                                selectedColor:
                                    Theme.of(context).primaryColorDark,
                                backgroundColor: Theme.of(context).primaryColor,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedSize =
                                        _sizesOfProduct[i].toString();
                                  });
                                },
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorDark)),
                                // labelPadding: EdgeInsets.all(10.0),
                                // labelStyle: TextStyle(fontSize: 18.0),
                              )
                          ],
                        ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 10.0, right: 10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       Text(
                        //         'Size :',
                        //         style: TextStyle(
                        //             fontSize: 20.0,
                        //             color: Theme.of(context).accentColor,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       Text(
                        //         widget._product['Size'],
                        //         style: TextStyle(
                        //           fontSize: 18.0,
                        //           color: Theme.of(context).accentColor,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 7.0,
                        // ),
                        // Divider(
                        //   color: Theme.of(context).accentColor,
                        // ),
                        // SizedBox(
                        //   height: 7.0,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: <Widget>[
                        //       Text(
                        //         'Discount :',
                        //         style: TextStyle(
                        //           fontSize: 20.0,
                        //           color: Theme.of(context).accentColor,
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10.0,
                        //       ),
                        //       Text(
                        //         '${(int.parse(widget.product['Discount Price']) * 100 )/ (int.parse(widget.product['Original Price']))} %',
                        //         style: TextStyle(
                        //           fontSize: 16.0,
                        //           color: Theme.of(context).accentColor,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, left: 10.0),
                          child: Text(
                            'Description :',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // for (String item in description)
                        for (var i = 0; i < _description.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: Text(
                              '${_description[i]}.',
                              // description[i],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        // for (var i = 0; i < 5; i++)
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20.0),
                        //   child: ListView.builder(
                        //     itemCount: description.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return Text(
                        //         '${description[index]}',
                        //         style: TextStyle(
                        //           fontSize: 16.0,
                        //           color: Theme.of(context).accentColor,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // child: Text(
                        //   // 'Can I Able to Do that soething which is awesome',
                        //   widget._product['Description'],
                        //   style: TextStyle(
                        //     fontSize: 16.0,
                        //     color: Theme.of(context).accentColor,
                        //   ),
                        //   // textAlign: TextAlign.jstart,
                        //   strutStyle: StrutStyle(
                        //     fontSize: 16.0,
                        //     height: 1.3,
                        //   ),
                        // ),
                        // ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, left: 10.0),
                          child: Text(
                            'Features & Details :',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // for (var i = 0; i < 5; i++)
                        for (var i = 0; i < _featuresAndDetails.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, left: 20.0),
                            child: Text(
                              '${i + 1}. ${_featuresAndDetails[i]}.',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor,
                              ),
                              // textAlign: TextAlign.jstart,
                              // strutStyle: StrutStyle(
                              //   fontSize: 16.0,
                              //   height: 1.3,
                              // ),
                            ),
                          ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        RaisedButton(
                          child: new Text(
                            'BUY NOW',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                            ),
                          ),
                          // padding: const EdgeInsets.symmetric(
                          //   horizontal: 25.0,
                          //   vertical: 15.0,
                          // ),
                          // elevation: 5.0,
                          // color: Theme.of(context).accentColor,
                          onPressed: () {
                            print('Value Of Size : $_selectedSize');
                            if (_selectedSize == null) {
                              ShowSnackBar().showSnackBar(
                                  context,
                                  "Please Select Size Of Product",
                                  _scaffoldState);
                            } else {
                              _mobileNumber = SharedP.sharedPreferences
                                  .getString('Mobile Number');
                              _name =
                                  SharedP.sharedPreferences.getString('Name');
                              _houseNo = SharedP.sharedPreferences
                                  .getString('House No');
                              _colony =
                                  SharedP.sharedPreferences.getString('Colony');
                              _landmark = SharedP.sharedPreferences
                                  .getString('Landmark');
                              if (_name == null) {
                                ShowDialog().showAccountCompletionDialog(context);
                              } else {
                                _settingModalBottomSheet(context);
                              }
                            }

                            // _loading = true;
                            // new Timer(Duration(seconds: 5), () {
                            //   _loading = false;
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Payment()));
                            // });
                            // setState(() {});
                          },
                          // shape: new RoundedRectangleBorder(
                          //   borderRadius: new BorderRadius.circular(30.0),
                          // ),
                          // // borderSide: BorderSide(color: Theme.of(context).accentColor),
                          // splashColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
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
            height: 200.0,
            margin: EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Container(
                //   width: 50.0,
                //   margin: EdgeInsets.only(bottom: 20.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20.0),
                //     border: Border.all(
                //       color: Colors.black.withOpacity(0.3),
                //       width: 5.0,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          // TableCell(
                          //   child: ,
                          // )
                          Text(
                            'Product :',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${widget._product['Name Of Product']} \n',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          // TableCell(
                          //   child: ,
                          // )
                          Text(
                            'Size :',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$_selectedSize \n',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          // TableCell(
                          //   child: ,
                          // )
                          Text(
                            'Amount :',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\u20B9 ${widget._product['Discount Price']}.00',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    String verifiedRandomNumber =
                        GenerateRandom().generateRandomNumber(5);
                    String nonVerifiedRandomNumber =
                        GenerateRandom().generateRandomNumber(5);
                    _verificationModal(
                        context, verifiedRandomNumber, nonVerifiedRandomNumber);
                    // Navigator.of(context).push(
                    //   PageTransition(
                    //     child: Payment(
                    //         widget._product['Images'].first,
                    //         _name,
                    //         _mobileNumber,
                    //         widget._product['Name Of Product'],
                    //         widget._product['Product Id'],
                    //         _houseNo,
                    //         _colony,
                    //         _landmark,
                    //         widget._product['Discount Price'],
                    //         widget._category,
                    //         widget._documentId),
                    //     type: PageTransitionType.fade,
                    //     duration: Duration(milliseconds: 500),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                    ),
                  ),
                  // color: Theme.of(context).accentColor,
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: 30.0, vertical: 15.0),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(30.0),
                  // ),
                  // splashColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          );
        });
  }

  void _verificationModal(
      context, verifiedRandomNumber, nonVerifiedRandomNumber) {
    List<Widget> items =
        getListButtons(verifiedRandomNumber, nonVerifiedRandomNumber);
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        builder: (BuildContext buildContext) {
          return Container(
            height: 200.0,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Container(
                //   width: 50.0,
                //   margin: EdgeInsets.only(bottom: 20.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20.0),
                //     border: Border.all(
                //       color: Colors.black.withOpacity(0.2),
                //       width: 5.0,
                //     ),
                //   ),
                // ),
                Text(
                  'I\'m Human 🙂:',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColorDark
                  ),
                ),
                Text(
                  '$verifiedRandomNumber',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // ListView(
                //   scrollDirection: Axis.horizontal,
                //   children: getListButtons(randomNumber),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: items,
                )
              ],
            ),
          );
        });
  }

  List<Widget> getListButtons(verifiedRandomNumber, nonVerifiedRandomNumber) {
    List<Widget> items = [
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            PageTransition(
              builder: (context) => Payment(
                widget._product['Images'],
                _name,
                _mobileNumber,
                widget._product['Name Of Product'],
                widget._product['Product Id'],
                _houseNo,
                _colony,
                _landmark,
                widget._product['Discount Price'],
                widget._category,
                _selectedSize,
                // widget._product['Size']
              ),
              // type: PageTransitionType.fade,
              // duration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Text(
          verifiedRandomNumber,
          style:
              TextStyle(fontSize: 15.0, color: Theme.of(context).primaryColor),
        ),
        splashColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColorDark,
        // borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
      ),
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          ShowSnackBar()
              .showSnackBar(context, 'You Are Not Human 😓', _scaffoldState);
        },
        child: Text(
          nonVerifiedRandomNumber,
          style:
              TextStyle(fontSize: 15.0, color: Theme.of(context).primaryColor),
        ),
        splashColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColorDark,
      ),
    ];
    items.shuffle();
    return items;
  }
}

class PhotoGalleryForProduct extends StatelessWidget {
  final image;
  PhotoGalleryForProduct(this.image);
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            image[index],
          ),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.contained * 2.8,
        );
      },
      itemCount: image.length,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }
}

// ! Junk Code ------------------------------------------------------------------

// body: NestedScrollView(
//   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrollin) {
//     return <Widget>[
// SliverList(delegate: SliverChildBuilderDelegate(
//   (context, i) {
//     return CarouselSlider(
//       autoPlay: true,
//       pauseAutoPlayOnTouch: Duration(seconds: 5),
//       height: MediaQuery.of(context).size.height * 0.60,
//       items: <Widget>[
//         for (var i = 0; i < widget._product['Images'].length; i++)
//           GestureDetector(
//             // child: Container(
//             //   margin: const EdgeInsets.only(top: 20.0, left: 20.0),
//             //   decoration: BoxDecoration(
//             //     image: DecorationImage(
//             //       image: NetworkImage(widget._product['Images'][i]),
//             //       fit: BoxFit.fitHeight,
//             //     ),
//             //     // border:
//             //     //     Border.all(color: Theme.of(context).accentColor),
//             //     borderRadius: BorderRadius.circular(20.0),
//             //   ),
//             // ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 7.0, vertical: 5.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.0),
//                 child: Image.network(
//                   widget._product['Images'][i],
//                   fit: BoxFit.fitHeight,
//                 ),
//               ),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 PageTransition(
//                     child: PhotoGalleryForProduct(
//                         widget._product['Images']),
//                     type: PageTransitionType.downToUp),
//               );
//             },
//           ),
//         // PhotoView(
//         //   imageProvider: NetworkImage(widget.product['Images'][i]),

//         // )
//       ],
//     );
//   },
// )),
//       SliverGrid.count(
//         crossAxisCount: 1,
//         children: <Widget>[
//           CarouselSlider(
//             autoPlay: true,
//             pauseAutoPlayOnTouch: Duration(seconds: 5),
//             height: MediaQuery.of(context).size.height * 0.60,
//             // aspectRatio: 0.5,
//             items: <Widget>[
//               for (var i = 0; i < widget._product['Images'].length; i++)
//                 GestureDetector(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 2.0, vertical: 5.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20.0),
//                       child: Image.network(
//                         widget._product['Images'][i],
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.of(context).push(
//                       PageTransition(
//                           child: PhotoGalleryForProduct(
//                               widget._product['Images']),
//                           type: PageTransitionType.downToUp),
//                     );
//                   },
//                 ),
//               // PhotoView(
//               //   imageProvider: NetworkImage(widget.product['Images'][i]),

//               // )
//             ],
//           ),
//         ],
//       )
//     ];
//   },
//   body: SingleChildScrollView(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Padding(
//           padding:
//               const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Brand : ',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   color: Theme.of(context).accentColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 '${widget._product['Name Of Brand']}',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   color: Theme.of(context).accentColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Padding(
//           padding:
//               const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Product : ',
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     color: Theme.of(context).accentColor,
//                     fontWeight: FontWeight.w600),
//                 textAlign: TextAlign.start,
//               ),
//               Text(
//                 '${widget._product['Name Of Product']}',
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     color: Theme.of(context).accentColor,
//                     fontWeight: FontWeight.w600),
//                 textAlign: TextAlign.start,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Padding(
//           padding:
//               const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Price : ',
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     color: Theme.of(context).accentColor,
//                     fontWeight: FontWeight.w600),
//               ),
//               Row(
//                 children: <Widget>[
//                   Text(
//                     '\u20B9',
//                     style: TextStyle(
//                       fontSize: 30.0,
//                       color: Theme.of(context).accentColor,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5.0,
//                   ),
//                   Text(
//                     widget._product['Discount Price'],
//                     style: TextStyle(
//                         fontSize: 24.0,
//                         color: Theme.of(context).primaryColorDark,
//                         fontWeight: FontWeight.bold),
//                     // textAlign: TextAlign.right
//                   ),
//                   SizedBox(
//                     width: 10.0,
//                   ),
//                   Text(
//                     widget._product['Original Price'],
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Theme.of(context).accentColor,
//                       decoration: TextDecoration.lineThrough,
//                       decorationColor:
//                           Theme.of(context).primaryColorLight,
//                       decorationThickness: 0.8,
//                     ),
//                   ),
//                 ],
//               )
//               // SizedBox(
//               //   width: 15.0,
//               // ),
//               // Text(
//               //   '${getDiscount()} 😮',
//               //   style: TextStyle(
//               //     fontSize: 18.0,
//               //     color: Colors.green,
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Padding(
//           padding:
//               const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Discount : ',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: Theme.of(context).primaryColorDark,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 // textAlign: TextAlign.start,
//               ),
//               Text(
//                 getDiscount(),
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: Theme.of(context).primaryColorDark,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Padding(
//           padding:
//               const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Size :',
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     color: Theme.of(context).accentColor,
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 widget._product['Size'],
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Theme.of(context).accentColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // SizedBox(
//         //   height: 7.0,
//         // ),
//         // Divider(
//         //   color: Theme.of(context).accentColor,
//         // ),
//         // SizedBox(
//         //   height: 7.0,
//         // ),
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 10.0, top: 8.0),
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.start,
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: <Widget>[
//         //       Text(
//         //         'Discount :',
//         //         style: TextStyle(
//         //           fontSize: 20.0,
//         //           color: Theme.of(context).accentColor,
//         //         ),
//         //       ),
//         //       SizedBox(
//         //         width: 10.0,
//         //       ),
//         //       Text(
//         //         '${(int.parse(widget.product['Discount Price']) * 100 )/ (int.parse(widget.product['Original Price']))} %',
//         //         style: TextStyle(
//         //           fontSize: 16.0,
//         //           color: Theme.of(context).accentColor,
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 15.0, left: 10.0),
//           child: Text(
//             'Description :',
//             style: TextStyle(
//                 fontSize: 20.0,
//                 color: Theme.of(context).accentColor,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 1.2),
//             textAlign: TextAlign.start,
//           ),
//         ),
//         // for (var i = 0; i < 5; i++)
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Text(
//             // 'Can I Able to Do that soething which is awesome',
//             widget._product['Description'],
//             style: TextStyle(
//               fontSize: 16.0,
//               color: Theme.of(context).accentColor,
//             ),
//             // textAlign: TextAlign.jstart,
//             strutStyle: StrutStyle(
//               fontSize: 16.0,
//               height: 1.3,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 15.0, left: 10.0),
//           child: Text(
//             'Features & Details :',
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Theme.of(context).accentColor,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 1.2,
//             ),
//             textAlign: TextAlign.start,
//           ),
//         ),
//         // for (var i = 0; i < 5; i++)
//         Padding(
//           padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
//           child: Text(
//             // 'Can I Able to Do that',
//             widget._product['Features & Details'],
//             style: TextStyle(
//               fontSize: 16.0,
//               color: Theme.of(context).accentColor,
//             ),
//             // textAlign: TextAlign.jstart,
//             strutStyle: StrutStyle(
//               fontSize: 16.0,
//               height: 1.3,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Divider(
//           color: Theme.of(context).accentColor,
//         ),
//         SizedBox(
//           height: 7.0,
//         ),
//         Center(
//           child:
//               //  _loading
//               //     ? Container(
//               //         height: 70.0,
//               //         margin: const EdgeInsets.only(bottom: 10.0),
//               //         child: Align(
//               //           alignment: Alignment.bottomCenter,
//               //           child: FlareAnimation().flareActor(),
//               //         ),
//               //       )
//               // :
//               RaisedButton(
//             child: new Text(
//               'BUY NOW',
//               style: TextStyle(
//                 color: Theme.of(context).primaryColor,
//                 fontSize: 18.0,
//               ),
//             ),
//             // padding: const EdgeInsets.symmetric(
//             //   horizontal: 25.0,
//             //   vertical: 15.0,
//             // ),
//             elevation: 5.0,
//             // color: Theme.of(context).accentColor,
//             onPressed: () {
//               // _loading = true;
//               // new Timer(Duration(seconds: 5), () {
//               //   _loading = false;
//               //   Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //           builder: (context) => Payment()));
//               // });
//               // setState(() {});
//               _mobileNumber = _preferences.getString('Mobile Number');
//               _name = _preferences.getString('Name');
//               _houseNo = _preferences.getString('House No');
//               _colony = _preferences.getString('Colony');
//               _landmark = _preferences.getString('Landmark');
//               if (_name == null) {
//                 showAccountCompletionDialog(context);
//               } else {
//                 _settingModalBottomSheet(context);
//               }
//             },
//             // shape: new RoundedRectangleBorder(
//             //   borderRadius: new BorderRadius.circular(30.0),
//             // ),
//             // // borderSide: BorderSide(color: Theme.of(context).accentColor),
//             // splashColor: Theme.of(context).primaryColor,
//           ),
//         ),
//         SizedBox(
//           height: 30.0,
//         )
//       ],
//     ),
//   ),
//   // SizedBox(
//   //   height: 20.0,
//   // ),
//   // Center(
//   //   child:
//   //       //  _loading
//   //       //     ? Container(
//   //       //         height: 70.0,
//   //       //         margin: const EdgeInsets.only(bottom: 10.0),
//   //       //         child: Align(
//   //       //           alignment: Alignment.bottomCenter,
//   //       //           child: FlareAnimation().flareActor(),
//   //       //         ),
//   //       //       )
//   //       // :
//   //       RaisedButton(
//   //     child: new Text(
//   //       'BUY NOW',
//   //       style: TextStyle(
//   //         color: Theme.of(context).primaryColor,
//   //         fontSize: 18.0,
//   //       ),
//   //     ),
//   //     padding: const EdgeInsets.symmetric(
//   //       horizontal: 25.0,
//   //       vertical: 15.0,
//   //     ),
//   //     elevation: 5.0,
//   //     // color: Theme.of(context).accentColor,
//   //     onPressed: () {
//   //       // _loading = true;
//   //       // new Timer(Duration(seconds: 5), () {
//   //       //   _loading = false;
//   //       //   Navigator.push(
//   //       //       context,
//   //       //       MaterialPageRoute(
//   //       //           builder: (context) => Payment()));
//   //       // });
//   //       // setState(() {});
//   //       _mobileNumber = _preferences.getString('Mobile Number');
//   //       _name = _preferences.getString('Name');
//   //       _houseNo = _preferences.getString('House No');
//   //       _colony = _preferences.getString('Colony');
//   //       _landmark = _preferences.getString('Landmark');
//   //       if (_name == null) {
//   //         showAccountCompletionDialog(context);
//   //       } else {
//   //         _settingModalBottomSheet(context);
//   //       }
//   //     },
//   //     // shape: new RoundedRectangleBorder(
//   //     //   borderRadius: new BorderRadius.circular(30.0),
//   //     // ),
//   //     // // borderSide: BorderSide(color: Theme.of(context).accentColor),
//   //     // splashColor: Theme.of(context).primaryColor,
//   //   ),
//   // ),
//   // SizedBox(
//   //   height: 30.0,
//   // ),
// ),
// );
// ),

// body: SingleChildScrollView(
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     // mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
//       // CarouselSlider(
//       //   autoPlay: true,
//       //   pauseAutoPlayOnTouch: Duration(seconds: 5),
//       //   height: MediaQuery.of(context).size.height * 0.60,

//       // items: [1, 2, 3, 4, 5].map((i) {
//       //   return Builder(
//       //     builder: (BuildContext context) {
//       //       return Container(
//       //         margin: const EdgeInsets.only(top: 20.0, left: 20.0),
//       //         decoration: BoxDecoration(
//       //             image: DecorationImage(
//       //                 image: AssetImage(
//       //                   BackgroundImage.of(context).backgroundImage,
//       //                 ),
//       //                 fit: BoxFit.cover),
//       //             border: Border.all(
//       //                 color: Theme.of(context).accentColor),
//       //             borderRadius: BorderRadius.circular(32.0)),
//       //       );
//       //     },
//       //   );
//       // }).toList(),
//       // ),
//       CarouselSlider(
//         autoPlay: true,
//         pauseAutoPlayOnTouch: Duration(seconds: 5),
//         height: MediaQuery.of(context).size.height * 0.60,
//         items: <Widget>[
//           for (var i = 0; i < widget._product['Images'].length; i++)
//             GestureDetector(
//               // child: Container(
//               //   margin: const EdgeInsets.only(top: 20.0, left: 20.0),
//               //   decoration: BoxDecoration(
//               //     image: DecorationImage(
//               //       image: NetworkImage(widget._product['Images'][i]),
//               //       fit: BoxFit.fitHeight,
//               //     ),
//               //     // border:
//               //     //     Border.all(color: Theme.of(context).accentColor),
//               //     borderRadius: BorderRadius.circular(20.0),
//               //   ),
//               // ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 7.0, vertical: 5.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20.0),
//                   child: Image.network(
//                     widget._product['Images'][i],
//                     fit: BoxFit.fitHeight,
//                   ),
//                 ),
//               ),
//               onTap: () {
//                 Navigator.of(context).push(
//                   PageTransition(
//                       child: PhotoGalleryForProduct(
//                           widget._product['Images']),
//                       type: PageTransitionType.downToUp),
//                 );
//               },
//             ),
//           // PhotoView(
//           //   imageProvider: NetworkImage(widget.product['Images'][i]),

//           // )
//         ],
//       ),
//       SizedBox(
//         height: 10.0,
//       ),
//       Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
//         margin:
//             const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//             border: Border.all(
//                 color: Theme.of(context).accentColor, width: 1.0)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 10.0, top: 8.0, right: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Brand : ',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Theme.of(context).accentColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     '${widget._product['Name Of Brand']}',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Theme.of(context).accentColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Divider(
//               color: Theme.of(context).accentColor,
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 10.0, top: 8.0, right: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Product : ',
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         color: Theme.of(context).accentColor,
//                         fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.start,
//                   ),
//                   Text(
//                     '${widget._product['Name Of Product']}',
//                     style: TextStyle(
//                         fontSize: 18.0,
//                         color: Theme.of(context).accentColor,
//                         fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.start,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Divider(
//               color: Theme.of(context).accentColor,
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 10.0, top: 8.0, right: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Price : ',
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         color: Theme.of(context).accentColor,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         '\u20B9',
//                         style: TextStyle(
//                           fontSize: 30.0,
//                           color: Theme.of(context).accentColor,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5.0,
//                       ),
//                       Text(
//                         widget._product['Discount Price'],
//                         style: TextStyle(
//                             fontSize: 24.0,
//                             color: Theme.of(context).primaryColorDark,
//                             fontWeight: FontWeight.bold),
//                         // textAlign: TextAlign.right
//                       ),
//                       SizedBox(
//                         width: 10.0,
//                       ),
//                       Text(
//                         widget._product['Original Price'],
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           color: Theme.of(context).accentColor,
//                           decoration: TextDecoration.lineThrough,
//                           decorationColor:
//                               Theme.of(context).primaryColorLight,
//                           decorationThickness: 0.8,
//                         ),
//                       ),
//                     ],
//                   )
//                   // SizedBox(
//                   //   width: 15.0,
//                   // ),
//                   // Text(
//                   //   '${getDiscount()} 😮',
//                   //   style: TextStyle(
//                   //     fontSize: 18.0,
//                   //     color: Colors.green,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Divider(
//               color: Theme.of(context).accentColor,
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 10.0, top: 8.0, right: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Discount : ',
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       color: Theme.of(context).primaryColorDark,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     // textAlign: TextAlign.start,
//                   ),
//                   Text(
//                     getDiscount(),
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       color: Theme.of(context).primaryColorDark,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Divider(
//               color: Theme.of(context).accentColor,
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 10.0, top: 8.0, right: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Size :',
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         color: Theme.of(context).accentColor,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     widget._product['Size'],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: Theme.of(context).accentColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // SizedBox(
//             //   height: 7.0,
//             // ),
//             // Divider(
//             //   color: Theme.of(context).accentColor,
//             // ),
//             // SizedBox(
//             //   height: 7.0,
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 10.0, top: 8.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.start,
//             //     crossAxisAlignment: CrossAxisAlignment.center,
//             //     children: <Widget>[
//             //       Text(
//             //         'Discount :',
//             //         style: TextStyle(
//             //           fontSize: 20.0,
//             //           color: Theme.of(context).accentColor,
//             //         ),
//             //       ),
//             //       SizedBox(
//             //         width: 10.0,
//             //       ),
//             //       Text(
//             //         '${(int.parse(widget.product['Discount Price']) * 100 )/ (int.parse(widget.product['Original Price']))} %',
//             //         style: TextStyle(
//             //           fontSize: 16.0,
//             //           color: Theme.of(context).accentColor,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Divider(
//               color: Theme.of(context).accentColor,
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 15.0, left: 10.0),
//               child: Text(
//                 'Description :',
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     color: Theme.of(context).accentColor,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 1.2),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//             // for (var i = 0; i < 5; i++)
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: Text(
//                 // 'Can I Able to Do that soething which is awesome',
//                 widget._product['Description'],
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 // textAlign: TextAlign.jstart,
//                 strutStyle: StrutStyle(
//                   fontSize: 16.0,
//                   height: 1.3,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Divider(
//               color: Theme.of(context).accentColor,
//             ),
//             SizedBox(
//               height: 7.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 15.0, left: 10.0),
//               child: Text(
//                 'Features & Details :',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   color: Theme.of(context).accentColor,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1.2,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//             // for (var i = 0; i < 5; i++)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
//               child: Text(
//                 // 'Can I Able to Do that',
//                 widget._product['Features & Details'],
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 // textAlign: TextAlign.jstart,
//                 strutStyle: StrutStyle(
//                   fontSize: 16.0,
//                   height: 1.3,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(
//         height: 20.0,
//       ),
//       Center(
//         child:
//             //  _loading
//             //     ? Container(
//             //         height: 70.0,
//             //         margin: const EdgeInsets.only(bottom: 10.0),
//             //         child: Align(
//             //           alignment: Alignment.bottomCenter,
//             //           child: FlareAnimation().flareActor(),
//             //         ),
//             //       )
//             // :
//             RaisedButton(
//           child: new Text(
//             'BUY NOW',
//             style: TextStyle(
//               color: Theme.of(context).primaryColor,
//               fontSize: 18.0,
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(
//             horizontal: 25.0,
//             vertical: 15.0,
//           ),
//           elevation: 5.0,
//           // color: Theme.of(context).accentColor,
//           onPressed: () {
//             // _loading = true;
//             // new Timer(Duration(seconds: 5), () {
//             //   _loading = false;
//             //   Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (context) => Payment()));
//             // });
//             // setState(() {});
//             _mobileNumber = _preferences.getString('Mobile Number');
//             _name = _preferences.getString('Name');
//             _houseNo = _preferences.getString('House No');
//             _colony = _preferences.getString('Colony');
//             _landmark = _preferences.getString('Landmark');
//             if (_name == null) {
//               showAccountCompletionDialog(context);
//             } else {
//               _settingModalBottomSheet(context);
//             }
//           },
//           // shape: new RoundedRectangleBorder(
//           //   borderRadius: new BorderRadius.circular(30.0),
//           // ),
//           // // borderSide: BorderSide(color: Theme.of(context).accentColor),
//           // splashColor: Theme.of(context).primaryColor,
//         ),
//       ),
//       SizedBox(
//         height: 30.0,
//       ),
//     ],
//   ),
// ),
// );

// persistentFooterButtons: <Widget>[
//   RaisedButton(
//     elevation: 3.0,
//     child: Padding(
//       padding: const EdgeInsets.only(
//           top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
//       child: new Text(
//         "ADD TO CART",
//         style: TextStyle(
//             color: Theme.of(context).accentColor, fontSize: 12.0),
//       ),
//     ),
//     color: Theme.of(context).accentColor,
//     onPressed: () {},
//     shape: new RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(30.0),
//         side: BorderSide(color: Theme.of(context).accentColor)),
//     splashColor: Theme.of(context).accentColor,
//   ),
// ],
// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
// floatingActionButton: loading
//     ? Container(
//         height: 70.0,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: FlareAnimation().flareActor(),
//         ),
//       )
//     : RaisedButton(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 30.0, vertical: 12.0),
//           child: new Text(
//             'BUY NOW',
//             style: TextStyle(
//                 color: Theme.of(context).accentColor,
//                 fontSize: 18.0,
//                 fontFamily: 'Gotham Light'),
//           ),
//         ),
//         onPressed: () {
//           loading = true;
//           new Timer(Duration(seconds: 5), () {
//             loading = false;
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Payment()));
//           });
//           setState(() {});
//         },
//         shape: new RoundedRectangleBorder(
//           borderRadius: new BorderRadius.circular(30.0),
//         ),
//         color: Theme.of(context).accentColor,
//         splashColor: Theme.of(context).accentColor,
//       ),
