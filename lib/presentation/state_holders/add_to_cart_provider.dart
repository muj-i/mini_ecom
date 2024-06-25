import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/services/network_caller/request_methods/post_request.dart';
import 'package:mini_ecom/data/utils/token_keeper.dart';
import 'package:mini_ecom/data/utils/urls.dart';

class AddToCartProvider extends ChangeNotifier {
  bool _addToCartInProgress = false;
  bool get addToCartInProgress => _addToCartInProgress;
  Future<bool> addToCart(int id) async {
    _addToCartInProgress = true;
    notifyListeners();
    final reqBody = {"product_id": id, "color": "Red", "size": "X", "qty": 1};

    final NetworkResponse response =
        await PostRequest.execute(Urls.ADD_TO_CART, reqBody);

    _addToCartInProgress = false;
    if (response.isSuccess) {
      log(response.responseData.toString());
      notifyListeners();
      return true;
    } else {
      TokenKeeper.clear();
      // _message = 'Product category list data fetch failed!';
      notifyListeners();
      return false;
    }
  }
}
