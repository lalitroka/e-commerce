import 'package:flutter/material.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({super.key});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            const Image(
              image: AssetImage('asset/loginpage.png'),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const Text(
              "Thank You For Your Order!",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              ' Your order will be deliverd on time',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "please  wait  some time ",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              " Thank you!",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
           
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/categorypage',
                 arguments: 'All'
                );
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
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(
                      color: Colors.indigo[900], fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
