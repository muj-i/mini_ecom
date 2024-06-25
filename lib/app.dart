import 'package:flutter/material.dart';
import 'package:mini_ecom/presentation/state_holders/add_to_cart_provider.dart';
import 'package:mini_ecom/presentation/state_holders/cart_provider.dart';
import 'package:mini_ecom/presentation/state_holders/delete_product_from_cart.dart';
import 'package:mini_ecom/presentation/state_holders/home_provider.dart';
import 'package:mini_ecom/presentation/state_holders/payment_gateway_provider.dart';
import 'package:mini_ecom/presentation/state_holders/user_login_provider.dart';
import 'package:mini_ecom/presentation/state_holders/varify_otp_provider.dart';
import 'package:mini_ecom/presentation/ui/screens/home.dart';
import 'package:provider/provider.dart';

class MiniEcomApp extends StatelessWidget {
  const MiniEcomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => VarifyOtpProvider()),
        ChangeNotifierProvider(create: (_) => DeleteProductFromCartProvider()),
        ChangeNotifierProvider(create: (_) => AddToCartProvider()),
        ChangeNotifierProvider(create: (_) => PaymentGatewayProvider()),
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
      ],
      child: MaterialApp(
        title: 'Provider Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: const Home(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        // useInheritedMediaQuery: true,
      ),
    );
  }
}
