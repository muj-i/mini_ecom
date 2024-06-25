import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/cart_list_model.dart';
import 'package:mini_ecom/data/utils/toast.dart';
import 'package:mini_ecom/presentation/state_holders/cart_provider.dart';
import 'package:mini_ecom/presentation/ui/widgets/cart_product_card.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<CartProvider>(context, listen: false);
      final isSuccess = await provider.getCartList();
      if (isSuccess == false) {
        if (mounted) {
          Navigator.pop(context);
        }
        Helper.showToastMessage('Session expired! Please login again.');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart List'),
      ),
      body: Consumer<CartProvider>(builder: (context, provider, widget) {
        List<CartData> cartData = provider.cartListModel.data ?? [];
        if (provider.getCartListInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (cartData.isEmpty) {
          return const Center(
            child: Text('Empty list'),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListView.builder(
            itemCount: cartData.length,
            itemBuilder: (context, index) {
              return CartProductCard(
                cartData: cartData[index],
              );
            },
          ),
        );
      }),
    );
  }
}
