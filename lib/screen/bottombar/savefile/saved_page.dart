import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myshop/service/database_service.dart';
import 'package:myshop/model/product_fav_model.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductFavModel>>(
        future: _databaseService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Not save the products '));
          } 
          else {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final productitem = snapshot.data![index];
                bool _isClicked = false;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/productviewpage',
                      arguments: productitem,
                    );
                  },
                  child: Container(
                    color: Colors.cyan[50],
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 180,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: productitem.image,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (productitem.discount.isEmpty)
                              Positioned(
                                top: 7,
                                left: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.cyan[50],
                                  ),
                                  child: Text(
                                    '${productitem.discount.toString()}% Off',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () async {
                                  final data = ProductFavModel(
                                    id: productitem.id, // Ensure id is correct
                                    title: productitem.title,
                                    description: productitem.description,
                                    discount: productitem.discount.toString(),
                                    price: productitem.price.toString(),
                                    image: productitem.image,
                                  );

                                  await DatabaseService().insertProduct(data);
                                  setState(() {
                                    _isClicked = !_isClicked;
                                  });
                                },
                                child: Icon(
                                  _isClicked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          productitem.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '\$${productitem.price.toString()}',
                          style: const TextStyle(color: Colors.green),
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
    );
  }
}
