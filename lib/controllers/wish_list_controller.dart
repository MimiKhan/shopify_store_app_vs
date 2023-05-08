

import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';

class WishListController extends GetxController{

  var favouritesList = <Product>[].obs;



  bool get keepAlive => true;

  int get itemsCount => favouritesList.length;

  toggleFavorites(Product product){
    if (favouritesList.contains(product)) {
      favouritesList.remove(product);
    } else {
      favouritesList.add(product);
    }
    update();
  }

  void removeProductFromWishList(Product product) {
    favouritesList.remove(product);
    update();
  }

}