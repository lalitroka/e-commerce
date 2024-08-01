import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myshop/model/product_fav_model.dart';
import 'package:myshop/service/database_service.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late Future<List<ProductFavModel>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = DatabaseService().getProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _futureProducts = DatabaseService().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Products'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<ProductFavModel>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No Saved Products"));
            } else {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final productItem = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                  
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
                                    imageUrl: productItem.image!,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () async {
                                    await DatabaseService()
                                        .deleteProduct(index)
                                        .then((value) {
                                      _refreshProducts();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            productItem.title!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$${productItem.price}',
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
      ),
    );
  }
}
