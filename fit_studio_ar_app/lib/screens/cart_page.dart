import 'package:fit_studio_ar_app/components/cart_card.dart';
import 'package:fit_studio_ar_app/models/products_list.dart';
import 'package:fit_studio_ar_app/screens/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:fit_studio_ar_app/components/cart_controller.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController controller=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox( height: 10,),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartCard(
                index: index,
                controller: controller,
                quantity: controller.products.values.toList()[index],
                product: controller.products.keys.toList()[index],
                );
            }
          ),
          bottomNavigationBar: const CartTotal(),
      ),
    );
  }
}

class CartTotal extends StatelessWidget {
  const CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController=Get.find();
    return Obx (() =>Container(
        height: MediaQuery.of(context).size.height * 0.125,
        decoration: const BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 85
                ),
              child: Row(
                children: [
                  const Text(
                    'Total:',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    )
                  ),
                  SizedBox(width: 70),
                  Text(
                    'Kshs ${cartController.total}',
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    )
                  ),
                  
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PaymentPage()));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 45)
              ), 
              child:const Text('Checkout'),
              )
          ],
        ),
      ),
    );
  }
}