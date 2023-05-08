import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/new_ui_designs/home_screen/ui/home_screen_ui.dart';
import 'package:shopify_store_app/services/configs.dart';
import 'package:shopify_store_app/services/connectivity_service.dart';
import 'package:shopify_store_app/services/init_configs.dart';
import 'package:shopify_store_app/services/theme_manager.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';
import 'package:shopify_store_app/shopify_models/shopify_config.dart';

import 'package:provider/provider.dart';
import 'package:shopify_store_app/views/cart/cart_ui/cart_screen2.0.dart';
import 'package:shopify_store_app/views/categories/collections_screen.dart';
import 'package:shopify_store_app/views/checkout/checkout_screen.dart';
import 'package:shopify_store_app/views/checkout/checkout_screen2.dart';
import 'package:shopify_store_app/views/checkout/shipping_select_screen.dart';
import 'package:shopify_store_app/views/home_ui/home_screen.dart';
import 'package:shopify_store_app/views/home_ui/home_screen2.dart';
import 'package:shopify_store_app/views/login/pages/register_page.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';
import 'package:shopify_store_app/views/others/no_internet_screen.dart';
import 'package:shopify_store_app/views/others/splash_screen.dart';
import 'package:shopify_store_app/views/others/wish_list_screen.dart';
import 'package:shopify_store_app/views/products_details/all_products_screen.dart';
import 'package:shopify_store_app/views/profile/profile_add_address_screen.dart';
import 'package:shopify_store_app/views/profile/profile_screen.dart';
import 'package:shopify_store_app/views/search/search_screen.dart';
import 'package:shopify_store_app/views/settings/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //internet check listener
  await ConnectivityService.instance.checkConnectionForFirstTime();

  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:
          Brightness.dark // Set status bar text color for light theme
      ));

  ShopifyConfig.setConfig(CustomConfig.shopifyStoreFrontAPIAccessToken,
      CustomConfig.shopifyStoreLink, CustomConfig.shopifyApiVersion);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            title: 'Shopify Store App',
            theme: themeNotifier.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: Colors.white,
                    textTheme: Theme.of(context).textTheme.apply(
                          // fontFamily: GoogleFonts.montserrat().fontFamily,
                          bodyColor: Colors.white, //<-- SEE HERE
                          displayColor: Colors.white, //<-- SEE HERE
                        ),
                  )
                : ThemeData(
                    useMaterial3: true,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.black,
                      actionsIconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                    ),
                    brightness: Brightness.light,
                    primaryColor: Colors.black,
                    primarySwatch: Colors.deepPurple,
                    textTheme: Theme.of(context).textTheme.apply(
                          // fontFamily: GoogleFonts.montserrat().fontFamily,
                          bodyColor: Colors.black, //<-- SEE HERE
                          displayColor: Colors.black, //<-- SEE HERE
                        ),
                  ),
            debugShowCheckedModeBanner: false,
            getPages: pagesList,
            initialBinding: GlobalConfigs(),
            initialRoute: '/splashScreen',
          ),
        );
      }),
    );
  }

  var pagesList = [
    GetPage(name: '/mainScreen', page: () => MainScreen(selectedIndex: 0)),
    GetPage(name: '/homeScreen', page: () => const HomeScreen()),
    GetPage(name: '/homeScreen2', page: () => const HomeScreen2()),
    GetPage(name: '/splashScreen', page: () => const SplashScreen()),
    GetPage(name: '/categoryScreen', page: () => const CategoryScreen()),
    GetPage(name: '/searchScreen', page: () => const SearchScreen()),
    GetPage(name: '/wishlistScreen', page: () => WishListScreen()),
    GetPage(name: '/cartScreen', page: () => CartScreen2()),
    GetPage(name: '/settings', page: () => const SettingScreen()),
    GetPage(name: '/allProducts', page: () => const AllProducts()),
    GetPage(name: '/noInternetScreen', page: () => const NoInternetScreen()),
    GetPage(name: '/registerScreen', page: () => const RegisterPage()),
    GetPage(
        name: '/profileAddAddressScreen',
        page: () => ProfileAddAddressScreen(
            address: Address(), addressType: AddressType.newAddress)),
    GetPage(name: '/profileScreen', page: () => const ProfileScreen()),
    GetPage(name: '/shippingSelect', page: () => const ShippingSelectScreen()),
    GetPage(name: '/checkoutScreen', page: () => const CheckoutScreen()),
    GetPage(name: '/checkoutScreen2', page: () => const CheckoutScreen2()),
    GetPage(name: '/homeScreenUI', page: () => const HomeScreenUI()),

    ];
}
