import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/enums/enums.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product_variant/product_variant.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_store.dart';

class ProductsListController extends GetxController {
  var productsList = <Product>[].obs;
  var onSaleProductsList = <Product>[].obs;
  var priceRangeProductsList = <Product>[].obs;

  var isDataLoading = true.obs;

  int get productsCount => productsList.length;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchProducts();
  }

  @override
  void refresh() {
    productsList.value = [];
    onSaleProductsList.value = [];
    onInit();
  }

  Future<void> _fetchProducts() async {
    try {
      final shopifyStore = ShopifyStore.instance;
      await shopifyStore.getAllProducts().then((value) {
        productsList.value = value;
        isDataLoading.value = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchSortedProducts(
      {required SortKeyProduct sortKeyProduct, required bool reverse}) async {
    try {
      productsList.value = [];
      final shopifyStore = ShopifyStore.instance;
      if (reverse) {
        await shopifyStore
            .getNProducts(250, sortKey: sortKeyProduct, reverse: true)
            .then((value) {
          productsList.value = value!;
        });
      } else {
        await shopifyStore
            .getNProducts(250, sortKey: sortKeyProduct)
            .then((value) {
          productsList.value = value!;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchFilteredProducts({required String queryForProducts}) async {
    try {
      productsList.value = [];
      final shopifyStore = ShopifyStore.instance;
      await shopifyStore.getAllProductsOnQuery(queryForProducts).then((value) {
        productsList.value = value;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchProductsOnSale() async {
    try {
      for (Product product in productsList) {
        for (ProductVariant variant in product.productVariants) {
          if (variant.compareAtPrice != null) {
            onSaleProductsList.add(product);
            break; // add the product to the filtered list and move on to the next product
          }
        }
      }
      productsList.value = onSaleProductsList;
    } catch (e) {
      debugPrint("Error in fetching items on sale : $e");
    }
  }

  Future<void> fetchProductsPriceRange(
      {int? startingPoint, int? endingPoint}) async {
    priceRangeProductsList.value = [];
    try {
      for (Product product in productsList) {
        for (ProductVariant variant in product.productVariants) {
          if (variant.price.amount > startingPoint! &&
              variant.price.amount <= endingPoint!) {
            priceRangeProductsList.add(product);
            break;
          }
        }
      }
      productsList.value = priceRangeProductsList;
    } catch (e) {
      debugPrint("Error in fetching items on sale : $e");
    }
  }
}
