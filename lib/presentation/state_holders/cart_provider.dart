import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/cart_list_model.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/services/network_caller/request_methods/get_request.dart';
import 'package:mini_ecom/data/utils/token_keeper.dart';
import 'package:mini_ecom/data/utils/urls.dart';

class CartProvider extends ChangeNotifier {
  bool _getCartListInProgress = false;
  final String _message = '';
  CartListModel _cartListModel = CartListModel();
  bool get getCartListInProgress => _getCartListInProgress;

  String get message => _message;
  CartListModel get cartListModel => _cartListModel;
  Future<bool> getCartList() async {
    _getCartListInProgress = true;
    notifyListeners();
    final NetworkResponse response =
        await GetRequest.execute(Urls.GET_CART_LIST);
    _getCartListInProgress = false;
    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseData!);
      //  _calculateTotalPrice();
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      TokenKeeper.clear();
      return false;
    }
  }
}
