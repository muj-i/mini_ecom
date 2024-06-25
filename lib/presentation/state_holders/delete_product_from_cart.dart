import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/cart_list_model.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/services/network_caller/request_methods/get_request.dart';
import 'package:mini_ecom/data/utils/urls.dart';

class DeleteProductFromCartProvider extends ChangeNotifier {
  bool _deleteCartItemInProgress = false;
  String _message = '';
  CartListModel _cartListModel = CartListModel();
  bool get deleteCartItemInProgress => _deleteCartItemInProgress;

  String get message => _message;
  CartListModel get cartListModel => _cartListModel;
  Future<bool> deleteCartItem(String id) async {
    _deleteCartItemInProgress = true;
    notifyListeners();
    final NetworkResponse response =
        await GetRequest.execute(Urls.DELETE_CART_ITEM(id));
    _deleteCartItemInProgress = false;
    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseData!);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      _message = 'Cart item delete failed! Try again';
      return false;
    }
  }
}
