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

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final productList = await _apiService.getProducts();
    final catList = await _apiService.getCategories();
    
    allProducts.assignAll(productList);
    categories.assignAll(['all', ...catList]);
    
    filterProducts();
    isLoading.value = false;
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
}
