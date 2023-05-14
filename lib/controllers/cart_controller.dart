import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/models/country_data_model.dart';
import 'package:shopify_store_app/shopify_models/flutter_simple_shopify.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line.dart';
import 'package:shopify_store_app/shopify_models/models/src/order/discount_allocations/discount_allocations.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';
import 'package:shopify_store_app/models/cart_model.dart';

class CartController extends GetxController {
  var cartModelItems = <CartModel>[].obs;
  var cartModelItemsSelected = <CartModel>[].obs;

  var lineItemsFromCart = <LineItem>[].obs;
  var linesFromCart = <CartLine>[].obs;

  int get cartModelItemsCount => cartModelItems.length;

  var countryData = <CountryDataModel>[].obs;

  @override
  onInit() async {
    super.onInit();
    await getCountryData().then((value) => countryData.value = value);
  }

  Future<List<CountryDataModel>> getCountryData() async {
    await Future.delayed(const Duration(seconds: 1));
    final jsonData =
        await rootBundle.loadString('assets/json/country_data.json');
    final jsonList = jsonDecode(jsonData) as List<dynamic>;

    return jsonList.map((e) => CountryDataModel.fromJson(e)).toList();
  }

  Future<List<LineItem>> getLineItems(
      List<CartModel> cartModelItemsList) async {
    for (var cartModelItem in cartModelItemsList) {
      lineItemsFromCart.add(LineItem(
        title: cartModelItem.product.title,
        quantity: cartModelItem.quantity,
        discountAllocations: [
          DiscountAllocations(
            allocatedAmount: PriceV2(amount: 0.0, currencyCode: 'USD'),
          ),
        ],
        variantId: cartModelItem.productVariant.id,
      ));
    }
    update();
    return lineItemsFromCart;
  }

  Future<List<CartLine>> getCartLines(
      List<CartModel> cartModelItemsList) async {
    for (var cartModelItem in cartModelItems) {
      linesFromCart.add(CartLine(
          merchandise: cartModelItem.productVariant,
          quantity: cartModelItem.quantity));
    }
    update();
    return linesFromCart.value;
  }

  void addItem(CartModel item) {
    if (cartModelItems.any((i) {
      return i.product.id == item.product.id &&
          i.productVariant.id == item.productVariant.id;
    })) {
      // Item already exists in the cart, update its quantity instead
      updateQuantity(item, item.quantity + 1);
    } else {
      cartModelItems.add(item);
    }
    update();
  }

  void updateQuantity(CartModel item, int newQuantity) {
    int index = cartModelItems.indexOf(item);
    if (index >= 0) {
      cartModelItems[index].quantity = newQuantity;
    }
  }

  void removeItem(CartModel item) {
    cartModelItems.remove(item);
    update();
  }

  void increaseQuantity(CartModel cartItem) {
    cartItem.quantity++;
    update();
  }

  void decreaseQuantity(CartModel cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      cartModelItems.remove(cartItem);
    }
    update();
  }

  double get totalCost {
    double cost = 0;
    for (var item in cartModelItems) {
      cost += item.productVariant.price.amount * item.quantity;
    }
    return cost;
  }

// double get totalCostSelectedItem {
//   double cost = 0;
//   for (var item in cartModelItemsSelected) {
//     cost += item.productVariant.price.amount * item.quantity;
//   }
//   return cost;
// }

/*final Map<Product, int> _cartItems = <Product, int>{}.obs;
  Map<Product, int> get cartItems => _cartItems;

  void addProduct(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    update();
  }

  void removeProduct(Product product) {
    _cartItems.remove(product);
    update();
  }

  void incrementQuantity(Product product) {
    _cartItems[product] = _cartItems[product]! + 1;
    update();
  }

  void decrementQuantity(Product product) {
    _cartItems[product] = _cartItems[product]! - 1;

    if (_cartItems[product] == 0) {
      removeProduct(product);
    }
    update();
  }

  double get totalPrice {
    double sum = 0;
    cartItems.forEach((product, quantity) {
      sum += product.productVariants.first.price.amount * quantity;
    });
    return sum;
  }*/
}

/*class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  // var cartItemQuantity = <Product,int>{}.obs;

  int get itemsCount => cartItems.length;

  // double get totalPrice => cartItems.fold(
  //     0,
  //     (previousValue, element) =>
  //         previousValue + element.productVariants.first.price.amount);

  addProduct(Product product) {
    cartItems.add(product);
    update();
  }

  removeProduct(Product product){
    cartItems.remove(product);
    update();
  }

  // void incrementQuantity(Product product) {
  //   var quantity = product.productVariants.first.quantityAvailable;
  //   quantity++;
  //   update();
  // }
  //
  // void decrementQuantity(Product product) {
  //   var quantity = product.productVariants.first.quantityAvailable;
  //   quantity--;
  //   if (quantity == 0) {
  //     removeProduct(product);
  //   }
  //   update();
  // }
}*/
