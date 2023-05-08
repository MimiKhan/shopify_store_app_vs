import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/enums/enums.dart';
import 'package:shopify_store_app/shopify_models/enums/src/sort_key_product.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_store.dart';

class ProductController extends GetxController {
  var productsBySearch = <Product>[].obs;
  var productById = <Product>[].obs;
  var productsByCollection = <Product>[].obs;

  int get productsByCollectionCount => productsByCollection.length;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> searchForProducts(String searchKeyword) async {
    try {
      final shopifyStore = ShopifyStore.instance;
      final products = await shopifyStore.getXProductsOnQueryAfterCursor(
        searchKeyword,
        4,
        null,
        sortKey: SortKeyProduct.RELEVANCE,
      );
      productsBySearch.value = products!;
      debugPrint("Product : ${products.first.productVariants.first.compareAtPrice?.formattedPrice ?? ''}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> searchForProduct(List<String> searchKeyword) async {
    try {
      final shopifyStore = ShopifyStore.instance;
      final products = await shopifyStore.getProductsByIds(searchKeyword);
      Future.delayed(const Duration(seconds: 3));
      productById.value = products!;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProductsByCollection({required String collectionId, Product? product}) async {
    try {
      final shopifyStore = ShopifyStore.instance;
      await shopifyStore
          .getXProductsAfterCursorWithinCollection(collectionId, 4,
              sortKey: SortKeyProductCollection.BEST_SELLING)
          .then((value) {
        productsByCollection.value = value!.where((newValue) => newValue.id != product?.id).toList();
        // productsByCollection.value = value!.where((newValue) => newValue != product).toList();
      });
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }



}
