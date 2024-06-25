import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/services/network_caller/request_methods/get_request.dart';
import 'package:mini_ecom/data/utils/urls.dart';

class UserLoginProvider extends ChangeNotifier {
  String _message = '';
  bool _sendOtpInProgress = false;
  bool get sendOtpInProgress => _sendOtpInProgress;

  String get message => _message;

  Future<bool> userLogin() async {
    _sendOtpInProgress = true;
    notifyListeners();
    final NetworkResponse responseUserLogin =
        await GetRequest.execute(Urls.USER_LOGIN);
    _sendOtpInProgress = false;
    if (responseUserLogin.isSuccess) {
      log(responseUserLogin.responseData.toString());
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      _message = '';
      return false;
    }
  }
}
