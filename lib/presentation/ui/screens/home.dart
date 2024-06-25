import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/product_model.dart';
import 'package:mini_ecom/data/utils/token_keeper.dart';
import 'package:mini_ecom/presentation/state_holders/home_provider.dart';
import 'package:mini_ecom/presentation/ui/screens/cart.dart';
import 'package:mini_ecom/presentation/ui/screens/varify_otp.dart';
import 'package:mini_ecom/presentation/ui/widgets/product_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mini Ecom'),
        actions: [
          IconButton(
            onPressed: () {
              if (TokenKeeper.accessToken == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VarifyOtp(
                              fromAddToCart: false,
                            )));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              }
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, widget) {
        List<ProductData> productData = provider.productModel.data ?? [];
        if (provider.getProductsListInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productData.isEmpty) {
          return const Center(
            child: Text('Empty list'),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListView.builder(
            itemCount: productData.length,
            itemBuilder: (context, index) {
              return ProductCard(
                productData: productData[index],
              );
            },
          ),
        );
      }),
    );
  }
}
