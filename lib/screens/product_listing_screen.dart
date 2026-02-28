import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/sliver_app_bar_delegate.dart';

class ProductListingScreen extends StatefulWidget {
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with TickerProviderStateMixin {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    // Initialize with whatever we have (likely empty or 'all')
    productController.initTabController(this);

    // Watch for category changes and re-init controller
    ever(productController.categories, (_) {
      productController.initTabController(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GetBuilder<ProductController>(
        builder: (controller) {
          if (controller.categories.isEmpty || controller.tabController == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return NestedScrollView(
            key: const PageStorageKey<String>('main_scroll_view'),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    expandedHeight: 220,
                    pinned: true,
                    backgroundColor: Colors.black,

                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(bottom: 110),
                      title: const Text(
                        'DARAZ SHOP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                       background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: .5),
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.5),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            left: 20,
                            right: 20,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Search in Daraz',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.white),
                        onPressed: () => Get.toNamed('/profile'),
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                          controller: controller.tabController,
                          isScrollable: true,
                          labelColor: Colors.orange,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.orange,
                          indicatorWeight: 3,
                          tabs: controller.categories
                              .map((c) => Tab(text: c.toUpperCase()))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: controller.tabController,
              children: controller.categories.map((category) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      final products = category == 'all'
                          ? controller.allProducts
                          : controller.allProducts
                              .where((p) => p.category == category)
                              .toList();

                      return RefreshIndicator(
                        onRefresh: controller.refreshData,
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
        },
      ),
    );
  }
}


