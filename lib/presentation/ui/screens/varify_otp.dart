import 'package:flutter/material.dart';
import 'package:mini_ecom/data/utils/toast.dart';
import 'package:mini_ecom/presentation/state_holders/user_login_provider.dart';
import 'package:mini_ecom/presentation/state_holders/varify_otp_provider.dart';
import 'package:mini_ecom/presentation/ui/screens/cart.dart';
import 'package:provider/provider.dart';

class VarifyOtp extends StatefulWidget {
  const VarifyOtp({super.key, required this.fromAddToCart});
  final bool fromAddToCart;

  @override
  State<VarifyOtp> createState() => _VarifyOtpState();
}

class _VarifyOtpState extends State<VarifyOtp> {
  @override
  void initState() {
    final provider = Provider.of<UserLoginProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.userLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final varifyOtpProvider =
        Provider.of<VarifyOtpProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Varify OTP'),
        ),
        body: Consumer<UserLoginProvider>(builder: (context, provider, widget) {
          return provider.sendOtpInProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text('Enter OTP sent to: dev.muj.i@icloud.com'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: varifyOtpProvider.otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'OTP',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer<VarifyOtpProvider>(
                        builder: (context, provider, widget) {
                      return provider.varifyOtpInProgress
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                provider.varifyOtp().then((isSuccess) {
                                  if (isSuccess) {
                                    if (this.widget.fromAddToCart) {
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Cart()));
                                    }
                                  } else {
                                    Helper.showToastMessage(
                                        'OTP varification failed');
                                  }
                                });
                              },
                              child: const Text('Varify OTP'),
                            );
                    }),
                  ],
                );
        }));
  }
}
