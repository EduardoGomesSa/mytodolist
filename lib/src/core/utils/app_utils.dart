import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  Future saveLocalData({
    required String key,
    required String data,
  }) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(key, data);
  }

  Future<String?> getLocalData({required String key}) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }

  Future removeLocalData({required String key}) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return await storage.remove(key);
  }

  Future<bool> createUserGuest() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    var created = await storage.setBool('is_guest', true);

    return created;
  }

  Future<bool> removeUserGuest() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    var removed = await storage.setBool('is_guest', false);

    return removed;
  }

  Future<bool> checkUserIsGuest() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    var isGuest = storage.getBool('is_guest');
    return isGuest != null && isGuest;
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();

    return dateFormat.format(dateTime);
  }

  void showToast({
    required String message,
    bool isError = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 18,
    );
  }
}
