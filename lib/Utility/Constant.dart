import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Constant {
  static AuthUser authUser;
  static BuildContext context;
  static bool isAlreadyLaunched = false;
  static final String chatPasswordFormat = "shoutme_";
  static bool isCallAlreadyRunning = false;
  static int participantUserCount = 0;
  static const methodChannel =
  const MethodChannel('com.shoutMe/RequestPermission');
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static int getIntFromMap(var json, String key) {
    if (json.containsKey(key)) {
      return json[key] as int;
    } else {
      return 0;
    }
  }

  static String getStringFromMap(var json, String key) {
    if (json.containsKey(key)) {
      return json[key] as String;
    } else {
      return "";
    }
  }

  static String milliToDate(int milliseconds) {
    if (milliseconds == null) return "";
    var dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return Jiffy(dt).format("hh:mm, do MMM yyyy");
  }
}

class AuthUser {
  int userId = 0;
  int myQuickBloxId = 0;
  String full_name = "";
  String authToken = "";
  String dob = "";
  String gender = "";
  String phone = "";
  String countryCode = "";
  String firsttime = "";
  String profile_picture = "";
  String bio_information = "";
  String latitude = "";
  String longitude = "";
  String email = "";
  String age = "";
}
