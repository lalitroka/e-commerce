import 'package:flutter/material.dart';
import 'package:myshop/model/categorymodel.dart';
import 'package:myshop/model/advertisemodel.dart';
import 'package:myshop/screen/bottombar/homepage/homewidth.dart';
import 'package:myshop/service/provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  void _handleSearch() {
    // String query = _searchController.text;
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawerMethod(),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: TextField(
              mouseCursor: MouseCursor.defer,
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Search...',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  suffixIcon: IconButton(
                      onPressed: _handleSearch,
                      icon: const Icon(Icons.search_outlined))),
              onSubmitted: (query) {
                _handleSearch();
              },
            ),
          ),

          actions: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal[50],
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 700) {
              return Stack(children: [
                SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 4,
                    ),
                    advertisement(),
                    const SizedBox(
                      height: 8,
                    ),
                    notifycontainer(),
                    const SizedBox(
                      height: 8,
                    ),
                    catetorycontainer(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      color: Colors.blue[50],
                      child: const Text('For You'),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Consumer<ProductProvider>(
                        builder:
                            (BuildContext __, productvalueprovider, Widget? _) {
                          if (productvalueprovider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (productvalueprovider.products.isEmpty) {
                            return const Center(
                              child: Text("No Product found"),
                            );
                          } else {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: productvalueprovider.products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                final productitem =
                                    productvalueprovider.products[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/productviewpage',
                                        arguments: productitem);
                                  },
                                  child: Container(
                                    color: Colors.cyan[50],
                                    height: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: SizedBox(
                                                height: 180,
                                                width: double.infinity,
                                                child: Image.asset(
                                                  '${productitem.image}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Icon(
                                                Icons.shopping_bag_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${productitem.title}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          productitem.price.toString(),
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ]),
                ),
              ]);
            }

            //
            //
            //
            //
            //
            //
            //
            //
            //
            else if (constraints.maxWidth > 700) {
              return const Column(
                children: [
                  Text('data'),
                ],
              );
            }
            return const Text('data not found');
          },
        ));
  }

  Padding catetorycontainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: SizedBox(
        height: 160,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.yellow,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/categorypage');
                },
                child: const Text(
                  'SEE ALL',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: categoryList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final categoryitem = categoryList[index];
              return SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        categoryitem.image,
                        width: 80,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      categoryitem.name,
                      textAlign: TextAlign.center, // Center text
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12, // Adjusted font size for visibility
                      ),
                    ),
                  ],
                ),
              );
            },
          ))
        ]),
      ),
    );
  }

  TextButton notifycontainer() {
    return TextButton(
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.only(left: 2, right: 2),
          height: 50,
          width: double.infinity,
          color: Colors.red[300],
          child: Center(
            child: RichText(
                text: TextSpan(style: const TextStyle(fontSize: 20), children: [
              const TextSpan(
                text: 'Delivery is ',
                style: TextStyle(color: Colors.black),
              ),
              WidgetSpan(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amberAccent,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: const Text(
                  '50%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              )),
              const TextSpan(
                text: 'cheaper',
                style: TextStyle(color: Colors.black),
              ),
            ])),
          ),
        ));
  }

  SizedBox advertisement() {
    return SizedBox(
      height: 90,
      child: Stack(children: [
        PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: advertiseList.length,
            itemBuilder: (context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                color: Colors.cyan[50],
                height: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image(
                  height: double.infinity,
                  width: double.infinity,
                  image: AssetImage(advertiseList[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              );
            }),
        Positioned(
          left: 150,
          bottom: 10,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: advertiseList.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.blue,
              dotColor: Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }
}