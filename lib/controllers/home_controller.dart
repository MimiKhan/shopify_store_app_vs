import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/enums/src/sort_key_collection.dart';
import 'package:shopify_store_app/shopify_models/enums/src/sort_key_product.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_store.dart';

class HomeController extends GetxController {

  var isDataLoading = true.obs;
  var bestSellingProducts = <Product>[].obs;
  var collections = <Collection>[].obs;
  // Rx<Shop?> currentShop = Rx<Shop?>(null);

  int get productsCount => bestSellingProducts.length;
  int get collectionsCount => collections.length;



  @override
  void onInit() {
    super.onInit();
    initData().whenComplete(() => isDataLoading.value = false);
  }



  Future<void> initData() async{
    // bestSellingProducts.value = (await _fetchProducts())!;
    // collections.value = (await _fetchCollections())!;
    _fetchProducts();
    _fetchCollections();
  }

  Future<void> _fetchProducts() async {
    try {
      // Future.delayed(const Duration(seconds: 1));
      final shopifyStore = ShopifyStore.instance;
      var bestSellingProducts = await shopifyStore.getNProducts(10,
              sortKey: SortKeyProduct.RELEVANCE);
      // debugPrint(bestSellingProducts!.first.toString());
      this.bestSellingProducts.value = bestSellingProducts!;
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }

  Future<void> _fetchCollections() async {
    try {
      final shopifyStore = ShopifyStore.instance;
      final collections = await shopifyStore.getAllCollections(
          sortKeyCollection: SortKeyCollection.UPDATED_AT);
      this.collections.value = collections;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
