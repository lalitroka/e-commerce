import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final productshop = arguments['productitem'];
    final pricevalue = arguments['value'];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Order ',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey), // Added border
                  ),
                  child: CachedNetworkImage(
                    imageUrl: productshop.image!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productshop.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Model: ${productshop.model!}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('Color : ${productshop.color!}'),

            // const SizedBox(height: 30),
            const Divider(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter promocode",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.red[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(pricevalue),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery'),
                Text('Free'),
              ],
            ),

            const Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total'),
                Text(pricevalue),
              ],
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/paymentinfopage',
                 arguments:{
                  'productshop': productshop, 
                 'pricevalue': pricevalue},
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
                    'Shipping & Payment Info',
                    style: TextStyle(
                      color: Colors.indigo[900],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
