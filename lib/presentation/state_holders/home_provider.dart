import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/product_model.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/services/network_caller/request_methods/get_request.dart';
import 'package:mini_ecom/data/utils/urls.dart';

class HomeProvider extends ChangeNotifier {
  bool _getProductsListInProgress = false;
  ProductModel _productModel = ProductModel();
  String _message = '';

  ProductModel get productModel => _productModel;

  bool get getProductsListInProgress => _getProductsListInProgress;

  String get message => _message;

  Future<bool> getProducts() async {
    _getProductsListInProgress = true;
    notifyListeners();
    final NetworkResponse response =
        await GetRequest.execute(Urls.GET_PRODUCT_LIST(1));

    _getProductsListInProgress = false;
    if (response.isSuccess) {
      log(response.responseData.toString());
      _productModel = ProductModel.fromJson(response.responseData);
      notifyListeners();
      return true;
    } else {
      _message = 'Product category list data fetch failed!';
      notifyListeners();
      return false;
    }
  }
}
