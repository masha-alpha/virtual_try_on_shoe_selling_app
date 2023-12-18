import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_studio_ar_app/components/cart_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});
  final TextEditingController _phoneNumberController = TextEditingController();
  final CartController cartController=Get.find();
  final double amount=0;

  void makePayment(String phone, String amount) async {
    var apiUrl = Uri.parse('https://fit-studio-payment-api.onrender.com/token');

    Map<String, dynamic> requestBody = {
      'contactNumber': phone,
      'amount': amount,
    };

    try {
      var response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json', 
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Payment successful
        print('Payment successful!');
        print('Response body: ${response.body}');
      } else {
        // Payment failed
        print('Payment failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error making payment: $error');
    }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 130,
        left: 30,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(65),
                topRight: Radius.circular(65),
              ),
          
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
                    const Text(
                      "Enter your phone number below:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Color(0xffdc9879)),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Color(0xffdc9879)),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    ElevatedButton(
                            onPressed: () {
                              String number =_phoneNumberController.text.trim();
                              makePayment(number, cartController.total.toString());
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(230, 70)
                            ),
                            child: Text(
                              "Make Payment",
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
               
                          ),
            ]
          ),
        ),
        ),
      ),
    );
  }
}