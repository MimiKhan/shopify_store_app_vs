import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/flutter_simple_shopify.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';

class CustomerController extends GetxController {
  late Address address;
  var ordersList = <Order>[].obs;



  Future<Address> addCustomerAddress(
      {required String firstName,
      required String lastName,
      required String address1,
      String? address2,
      required String city,
      required String country,
      required String province,
      required String zip,
      required String phone,
      required String customerAccessToken}) async {
    var shopifyCustomer = ShopifyCustomer.instance;
    var address = await shopifyCustomer.customerAddressCreate(
        firstName: firstName,
        lastName: lastName,
        address1: address1,
        address2: address2,
        city: city,
        zip: zip,
        phone: phone,
        country: country,
        province: province,
        customerAccessToken: customerAccessToken);
    this.address = address;
    return address;
  }

  Future<void> deleteCustomerAddress(
      {required String userToken, required String addressId}) async {
    var shopifyCustomer = ShopifyCustomer.instance;
    await shopifyCustomer.customerAddressDelete(
        customerAccessToken: userToken, addressId: addressId);
  }

  Future<void> updateCustomerAddress({
    required String userToken,
    required String addressId,
    required String firstName,
    required String lastName,
    required String address1,
    String? address2,
    required String city,
    required String country,
    required String province,
    required String zip,
    required String phone,
  }) async {
    var shopifyCustomer = ShopifyCustomer.instance;
    await shopifyCustomer.customerAddressUpdate(
      customerAccessToken: userToken,
      id: addressId,
      firstName: firstName,
      lastName: lastName,
      address1: address1,
      address2: address2,
      city: city,
      province: province,
      country: country,
      zip: zip,
      phone: phone,
    );
  }

  Future<void> getCustomersOrders(String accessToken) async {
    ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
    var data = await shopifyCheckout.getAllOrders(accessToken,
        sortKey: SortKeyOrder.PROCESSED_AT);

    if (data == null) {
      debugPrint('No orders Yet for this customer.');
    }
    ordersList.value = data ?? <Order>[];
  }
}
