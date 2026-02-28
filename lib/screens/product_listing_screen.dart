import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/sliver_app_bar_delegate.dart';

class ProductListingScreen extends StatefulWidget {
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> with TickerProviderStateMixin {
  final ProductController productController = Get.put(ProductController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    
    ever(productController.categories, (categories) {
      if (categories.isNotEmpty && _tabController.length != categories.length) {
        setState(() {
          _tabController = TabController(
            length: categories.length, 
            vsync: this,
            initialIndex: 0,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (productController.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_tabController.length != productController.categories.length) {
          return const Center(child: CircularProgressIndicator());
        }

        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 1. Collapsible Header
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('DARAZ SHOP', 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
                          fit: BoxFit.cover,
                        ),
                        Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3))),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () => Get.toNamed('/profile'),
                    ),
                  ],
                  bottom: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.orange,
                    tabs: productController.categories.map((c) => Tab(text: c.toUpperCase())).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: productController.categories.map((category) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    // Filter products for this specific category
                    final products = category == 'all' 
                      ? productController.allProducts 
                      : productController.allProducts.where((p) => p.category == category).toList();

                    return RefreshIndicator(
                      onRefresh: productController.refreshData,
                      child: CustomScrollView(
                        key: PageStorageKey<String>(category),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          if (products.isEmpty)
                            const SliverFillRemaining(
                              child: Center(child: Text('No products found')),
                            )
                          else
                            SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return ProductCard(product: products[index]);
                                  },
                                  childCount: products.length,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}
