import 'package:flutter/material.dart';
import 'package:mini_ecom/data/models/cart_list_model.dart';
import 'package:mini_ecom/presentation/state_holders/cart_provider.dart';
import 'package:mini_ecom/presentation/state_holders/delete_product_from_cart.dart';
import 'package:mini_ecom/presentation/ui/screens/payment_gateway.dart';
import 'package:provider/provider.dart';

class CartProductCard extends StatelessWidget {
  final CartData cartData;
  const CartProductCard({
    super.key,
    required this.cartData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(cartData.product?.image ??
                    'https://assets.adidas.com/images/w_600,f_auto,q_auto/f9d52817f7524d3fb442af3b01717dfa_9366/Runfalcon_3.0_Shoes_Black_HQ3790_01_standard.jpg'),
              ),
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          cartData.product?.title ?? 'Product name not found',
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final deleteProductProvider =
                              Provider.of<DeleteProductFromCartProvider>(
                                  context,
                                  listen: false);
                          deleteProductProvider
                              .deleteCartItem(cartData.productId.toString());
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.getCartList();
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 18,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Product Id: ${cartData.product?.id.toString()}',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartData.product?.price ?? '0',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 40, 4, 1),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentGateway(
                                        price: cartData.product?.price
                                                .toString() ??
                                            '0')));
                          },
                          child: const Text('Buy Now'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
