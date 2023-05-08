

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/flutter_simple_shopify.dart';

class CollectionsListController extends GetxController{
  var collectionsList = <Collection>[].obs;
  int get collectionCount => collectionsList.length;

  @override
  void onInit() {
    super.onInit();
    _fetchCollections();
  }


  Future<void> _fetchCollections() async {
    try {
      Future.delayed(const Duration(seconds: 1));
      final shopifyStore = ShopifyStore.instance;
      final collections = await shopifyStore.getAllCollections();
      // Future.delayed(const Duration(seconds: 5));
      collectionsList.value = collections;

    } catch (e) {
      debugPrint(e.toString());
    }
  }

}