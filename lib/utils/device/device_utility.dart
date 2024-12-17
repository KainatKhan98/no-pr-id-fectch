import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DevUtils {
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color)
    );
  }

  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url))  {
      await launchUrlString(url);
    } else{
      throw 'Could not launch $url';
    }
  }

}