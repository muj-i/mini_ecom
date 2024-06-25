import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/services/network_caller/request_methods/get_request.dart';
import 'package:mini_ecom/data/utils/token_keeper.dart';
import 'package:mini_ecom/data/utils/urls.dart';

class VarifyOtpProvider extends ChangeNotifier {
  bool _varifyOtpInProgress = false;
  String _message = '';
  bool get varifyOtpInProgress => _varifyOtpInProgress;
  String get message => _message;
  final TextEditingController otpController = TextEditingController();

  Future<bool> varifyOtp() async {
    _varifyOtpInProgress = true;
    notifyListeners();
    final NetworkResponse responseOtpVarify =
        await GetRequest.execute(Urls.VERIFY_OTP(otpController.text.trim()));
    _varifyOtpInProgress = false;
    if (responseOtpVarify.isSuccess) {
      TokenKeeper.setTokens(responseOtpVarify.responseData['data']).then((_) {
        log(TokenKeeper.accessToken ?? 'no token found');
      });
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      _message = '';
      return false;
    }
  }
}
