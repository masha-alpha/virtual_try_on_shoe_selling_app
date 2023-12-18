import 'package:flutter/material.dart';
import 'package:fit_studio_ar_app/models/products_list.dart';
import 'package:fit_studio_ar_app/components/cart_controller.dart';

class CartCard extends StatelessWidget {
  final CartController controller;
  final int quantity;
  final ProductItem product;
  final int index;
  const CartCard(
      {super.key,
      required this.index,
      required this.controller,
      required this.product,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Image.asset(
              products[index].bgUrl,
              height: 100,
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.349,
              child: Text(products[index].itemName),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      controller.removeProduct(product);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                  Text('$quantity'),
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      controller.addProduct(product);
                    },
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
