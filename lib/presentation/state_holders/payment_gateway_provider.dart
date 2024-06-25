import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayProvider extends ChangeNotifier {
  late WebViewController webViewController;
  bool isLoading = false;

  void onInit(String price) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading = true;
            notifyListeners();
          },
          onPageFinished: (String url) {
            isLoading = false;
            notifyListeners();
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://sandbox.sslcommerz.com/gwprocess/v4/bankgw/indexhtmlOTP.php?mamount=$price&ssl_id=24062515522769SAXpIBCFtU5Nt&Q=REDIRECT&SESSIONKEY=230DA78F49409031AE9DE572784ED20C&tran_type=success&cardname=mastercard'));
  }
}
