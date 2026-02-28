import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var allProducts = <Product>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = 'all'.obs;
  var displayedProducts = <Product>[].obs;

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void initTabController(TickerProvider vsync) {
    if (categories.isNotEmpty) {
      // Safely dispose old controller
      final oldController = tabController;
      
      tabController = TabController(
        length: categories.length,
        vsync: vsync,
        initialIndex: categories.indexOf(selectedCategory.value).clamp(0, categories.length - 1),
      );
      
      tabController!.addListener(() {
        if (!tabController!.indexIsChanging) {
          changeCategory(categories[tabController!.index]);
        }
      });

      // Schedule update for next frame to avoid "Build scheduled during frame"
      WidgetsBinding.instance.addPostFrameCallback((_) {
        oldController?.dispose();
        update();
      });
    }
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final productList = await _apiService.getProducts();
    final catList = await _apiService.getCategories();
    
    allProducts.assignAll(productList);
    categories.assignAll(['all', ...catList]);
    
    filterProducts();
    isLoading.value = false;
    update(); // Notify that categories are ready
  }

  void filterProducts() {
    if (selectedCategory.value == 'all') {
      displayedProducts.assignAll(allProducts);
    } else {
      displayedProducts.assignAll(
        allProducts.where((p) => p.category == selectedCategory.value).toList(),
      );
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }

  Future<void> refreshData() async {
    await fetchData();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
