import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentCheckOut extends StatefulWidget {
  const PaymentCheckOut({super.key});

  @override
  State<PaymentCheckOut> createState() => _PaymentCheckOutState();
}

class _PaymentCheckOutState extends State<PaymentCheckOut> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final productshop = arguments['productshop'];
    final pricevalue = arguments['pricevalue'];
    final userName = arguments['userName'] as String?;
    final address = arguments['address'] as String?;
    final phoneNumber = arguments['phoneNumber'] as String?;
    final email = arguments['email'] as String?;
    final cardNumber = arguments['cardNumber'] as String?;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Checkout')),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("My order",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      )),
                  Text(pricevalue)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 7,
              color: Colors.blue[50],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              color: Colors.grey[200],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(right: 70, left: 8),
                            child: Text(
                              productshop.title,
                              style: const TextStyle(fontSize: 20),
                            )),
                      ),
                      const Text('free'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery'),
                        Text('free'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("Shipping & payment info",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 7,
              color: Colors.blue[50],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              color: Colors.grey[200],
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'username: ',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: userName.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Address: ',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: address.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Card No.: ',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: cardNumber.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Phone No.: ',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: phoneNumber.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Email: ',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: email.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(
                  context,
                  '/successorderpage',
                );
                await _saveOrderHistory(productshop.title, pricevalue);
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Confirm Order')),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _saveOrderHistory(String productshop, String pricevalue) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': user.uid,
        'productshop': productshop,
        'pricevalue': pricevalue,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  } catch (e) {
    throw Exception(e);
  }
}
