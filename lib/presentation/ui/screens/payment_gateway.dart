import 'package:flutter/material.dart';
import 'package:mini_ecom/presentation/state_holders/payment_gateway_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGateway extends StatelessWidget {
  const PaymentGateway({super.key, required this.price});
  final String price;
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PaymentGatewayProvider>(context, listen: false);
    provider.onInit(price);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Payment Gateway',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: provider.webViewController),
          Consumer<PaymentGatewayProvider>(
              builder: (context, controller, widget) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
