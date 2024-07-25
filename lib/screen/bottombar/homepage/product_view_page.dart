import 'package:flutter/material.dart';
import 'package:myshop/model/productmodel.dart';

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({super.key});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  int value = 0;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final ProductModel productitem =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Stack(clipBehavior: Clip.none, children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 37,
              ),
              Positioned(
                bottom: -10,
                left: -3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        value;
                      });
                    },
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.right,
                    ),
                  )),
                ),
              ),
            ]),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image(
                  image: AssetImage(productitem.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productitem.name,
                    style: const TextStyle(
                      fontFamily: 'oswald',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.cyan[100], shape: BoxShape.circle),
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        size: 36,
                      ))
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productitem.price.toString(),
                    style: const TextStyle(
                      fontFamily: 'oswald',
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 238, 225, 225),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                               count++;
                              value += productitem.price.toInt();
                             
                            });
                          },
                          icon: const Icon(Icons.remove),
                          iconSize: 25,
                        ),
                        Text(count.toString()),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (count > 0) {
                                 count--;
                                value -= productitem.price.toInt();
                              }
                            });
                          },
                          icon: const Icon(Icons.add),
                          iconSize: 25,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'StockQuantity: ${productitem.stockQuantity.toString()}',
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'oswald',
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                productitem.description,
                style: const TextStyle(
                    fontFamily: 'montserrat',
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Color',
                style: TextStyle(
                  fontFamily: 'oswald',
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue[400],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Center(
                  child: Text(
                    'Leave A Review',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // ListView.separated(
              //   separatorBuilder: (context, index) {
              //     return const SizedBox(
              //       height: 10,
              //     );
              //   },
              //   itemCount: 10,
              //   itemBuilder: (contex, index) {
              //     return const SizedBox(
              //         height: 600,
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Icon(Icons.person_2),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Expanded(
              //                   child: Text(
              //                 '''I've never felt more confident during my workouts until I tried FlexFit Training Shoes. They allow me to push myself to the limit every time.''',
              //                 softWrap: true,
              //               )),
              //               // ],) ,
              //             ],
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // )
            ]),
          ),
        ));
  }
}
