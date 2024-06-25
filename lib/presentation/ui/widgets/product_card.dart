import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/product_model.dart';
import 'package:mini_ecom/data/utils/toast.dart';
import 'package:mini_ecom/presentation/state_holders/add_to_cart_provider.dart';
import 'package:mini_ecom/presentation/ui/screens/varify_otp.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductData? productData;

  const ProductCard({
    super.key,
    this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  productData?.image ?? '',
                  fit: BoxFit.contain,
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productData?.title ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Price ৳${productData?.price ?? ''}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Consumer<AddToCartProvider>(
                        builder: (context, provider, widget) {
                      return provider.addToCartInProgress
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color.fromARGB(255, 43, 2, 2),
                                        foregroundColor: Colors.white),
                                    child: const Text(
                                      'Add to cart',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    onPressed: () async {
                                      final isSuccess = await provider
                                          .addToCart(productData!.id!);
                                      if (isSuccess) {
                                        Helper.showToastMessage(
                                            'Product added to cart');
                                      } else {
                                        Navigator.push(
                                            // ignore: use_build_context_synchronously
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const VarifyOtp(
                                                        fromAddToCart: true)));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
