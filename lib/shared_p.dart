import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart' show GlobalKey, ScaffoldState;
import 'package:shared_preferences/shared_preferences.dart';

class SharedP {
  static SharedPreferences sharedPreferences;
  static Firestore firestore;
  static CloudFunctions cloudFunctions;
  static GlobalKey<ScaffoldState> scaffoldState;
}
