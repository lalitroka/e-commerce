import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myshop/model/product_fav_model.dart';
import 'package:myshop/service/api/product_model.dart';
import 'package:myshop/service/database_service.dart';
import 'package:myshop/service/provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? selectedCategory;
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedCategory = ModalRoute.of(context)!.settings.arguments as String;

    final uniqueCategories =
        Provider.of<ProductProvider>(context, listen: false)
            .products
            .map((product) => product.category)
            .toSet()
            .toList();
    final allCategories = ['All', ...uniqueCategories];

    _tabController.dispose();
    _tabController = TabController(length: allCategories.length, vsync: this);

    final initialIndex = allCategories.indexOf(selectedCategory ?? 'All');
    _tabController.index = initialIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, categoryProduct, child) {
        final uniqueCategories = categoryProduct.products
            .map((product) => product.category)
            .toSet()
            .toList();
        final allCategories = ['All', ...uniqueCategories];

        return DefaultTabController(
          length: allCategories.length,
          child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _handleSearch(_searchController.text.trim()),
                      icon: const Icon(Icons.search_outlined),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                  ),
                  onSubmitted: _handleSearch,
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: allCategories
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: allCategories.map((category) {
              final filteredProducts =
                      categoryProduct.products.where((product) {
                    final title = product.title?.toLowerCase() ?? '';
                    final query = searchQuery.trim().toLowerCase();
                    final queryTokens = query.split(RegExp(r'\s+'));
                    final titleTokens = title.split(RegExp(r'\s+'));
                    bool matchesQuery =
                        queryTokens.any((token) => titleTokens.contains(token));
                    return (product.category == category ||
                            category == 'All') &&
                        (searchQuery.isEmpty || matchesQuery);
                  }).toList();

                  return GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final productItem = filteredProducts[index];
                      return _buildProductItem(context, productItem, index);
                    },
                  );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductItem(
      BuildContext context, Products productItem, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/productviewpage',
            arguments: productItem);
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
                if (productItem.discount != null)
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
                        '${productItem.discount!.toString()}% Off',
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
                        id: index,
                        title: productItem.title.toString(),
                        description: productItem.description.toString(),
                        discount: productItem.discount,
                        image: productItem.image.toString(),
                        price: productItem.price,
                      );

                      await DatabaseService().insertProduct(data);
                    },
                    child: const Icon(Icons.favorite_border_outlined),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '${productItem.title}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              productItem.price.toString(),
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
