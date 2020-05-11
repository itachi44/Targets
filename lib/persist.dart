import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Persist{
  Future<void> setId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }
}
