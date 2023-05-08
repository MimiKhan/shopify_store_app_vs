import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/enums/enums.dart';
import 'package:shopify_store_app/shopify_models/enums/src/sort_key_collection.dart';
import 'package:shopify_store_app/shopify_models/enums/src/sort_key_product.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_store.dart';

class HomeScreenController extends GetxController {

  var isDataLoading = true.obs;
  var bestSellingProducts = <Product>[].obs;
  var collections = <Collection>[].obs;

  // Rx<Shop?> currentShop = Rx<Shop?>(null);

  int get productsCount => bestSellingProducts.length;

  int get collectionsCount => collections.length;

  var _chipIndex = 0.obs;
  var chipsDataList = <String>[].obs;


  int get chipIndex => _chipIndex.value;

  setChipIndex({required int newIndex}) {
    _chipIndex.value = newIndex;
    print(
        "Choice Chip Selected :Home Screen Controller: ${chipsDataList[_chipIndex
            .value]}");
    if (chipsDataList[_chipIndex.value] == 'All') {
      _fetchProducts();
    } else {
      String collectionName = chipsDataList[newIndex];
      for (var element in collections) {
        if (element.title == collectionName) {
          _fetchProductsByCollection(collectionId: element.id);
          break;
        }
      }
    }
    update();
  }


  @override
  void onInit() {
    super.onInit();
    initData().whenComplete(() => isDataLoading.value = false);
  }

  void getCollectionsTitle() {
    chipsDataList.add("All");
    for (var element in collections) {
      chipsDataList.add(element.title);
    }
    print("Collections List :: ${chipsDataList.length}");
    update();
  }


  Future<void> initData() async {
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
          sortKey: SortKeyProduct.BEST_SELLING);
      // debugPrint(bestSellingProducts!.first.toString());
      this.bestSellingProducts.value = bestSellingProducts!;
    } catch (exception) {
      debugPrint(exception.toString());
    }
    update();
  }


  Future<void> _fetchProductsByCollection(
      {required String collectionId}) async {
    try {
      // Future.delayed(const Duration(seconds: 1));
      final shopifyStore = ShopifyStore.instance;
      await shopifyStore
          .getXProductsAfterCursorWithinCollection(collectionId,10)
          .then((value) {
        bestSellingProducts.value = value!;
      });
    } catch (exception) {
      debugPrint(exception.toString());
    }
    update();
  }

  Future<void> _fetchCollections() async {
    try {
      final shopifyStore = ShopifyStore.instance;
      final collections = await shopifyStore.getAllCollections(
          sortKeyCollection: SortKeyCollection.UPDATED_AT);
      this.collections.value = collections;
      chipsDataList.clear();
      getCollectionsTitle();
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }
}
