// ignore_for_file: constant_identifier_names, non_constant_identifier_names

abstract class Urls {
  Urls._();

  static const String _BASE_URL = "https://ecom-api.teamrabbil.com/api";

  static String GET_PRODUCT_LIST(int categoryId) =>
      "$_BASE_URL/ListProductByCategory/$categoryId";

  static const String USER_LOGIN = "$_BASE_URL/UserLogin/dev.muj.i@icloud.com";
  static String VERIFY_OTP(String otp) =>
      "$_BASE_URL/VerifyLogin/dev.muj.i@icloud.com/$otp";

  static const String GET_CART_LIST = "$_BASE_URL/CartList";
  static const String ADD_TO_CART = "$_BASE_URL/CreateCartList";
  static String DELETE_CART_ITEM(String id) => '$_BASE_URL/DeleteCartList/$id';
}
