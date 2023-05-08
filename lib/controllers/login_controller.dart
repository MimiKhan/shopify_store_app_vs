import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/flutter_simple_shopify.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';

class LoginController extends GetxController {
  // late ShopifyUser newUser;
  Rx<ShopifyUser?> currentUser = Rx<ShopifyUser?>(null);
  var addressList = <Address>[].obs;
  // ShopifyUser? currentUser;
  var userAccessToken = ''.obs;


  Future<void> checkUser()async{
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    var user = await shopifyAuth.currentUser();
    var accessToken = await shopifyAuth.currentCustomerAccessToken;
    currentUser.value = user;
    addressList.value = user?.address?.addressList ?? [];
    userAccessToken.value = accessToken ?? '';
  }

  Future<void> createUser(
      {String? firstName,

      String? lastName,
      required String email,
      required String password}) async {
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;

    await shopifyAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName);

  }

  Future<void> signInWithEmailPass(
      {required String email, required String password}) async {
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    var signIn = await shopifyAuth.signInWithEmailAndPassword(
        email: email, password: password);
    debugPrint("Sign in User : ${signIn.id}");
    userAccessToken.value =  await shopifyAuth.currentCustomerAccessToken ?? '';

    currentUser.value = signIn;
  }

  Future<void> signout()async{
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    await shopifyAuth.signOutCurrentUser().whenComplete(() {
      userAccessToken.value = '';
      currentUser.value = null;
    });
    update();
  }

  Future<void> forgottenPassword(String email)async{
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    await shopifyAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> renewCustomerToken(String userToken)async{
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    await shopifyAuth.renewCurrentAccessToken(userAccessToken.value);
    update();
  }

}
