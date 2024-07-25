import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, 
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            physics: NeverScrollableScrollPhysics(),
            isScrollable: true,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Men'),
              Tab(text: 'Women'),
              Tab(text: 'Formal'),
              Tab(text: 'children'),
            ],
          ),
        ),
      body:const TabBarView(
          children: [
            Center(child: Text('All')),
            Center(child: Text('Men')),
            Center(child: Text('Women')),
            Center(child: Text('formal')),
            Center(child: Text('children')),
          ],
        ),
      ),
    );
  }
}