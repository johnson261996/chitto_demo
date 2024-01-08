import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String answer = '';
  String _userId = "";
  String _verificationId = "";

  String get userId => _userId;
  String get verificationId => _verificationId;

  void setAnswer(String newAnswer) {
    answer = newAnswer;
    notifyListeners();
  }

   void setVerificationId(String verificationId) {
    _verificationId = verificationId;
    notifyListeners();
  }

}