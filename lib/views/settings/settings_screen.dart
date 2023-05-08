import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/controllers/settings_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/checkout/new_checkout_design_screen.dart';
import 'package:shopify_store_app/views/login/pages/login_page.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';
import 'package:shopify_store_app/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopify_store_app/services/theme_manager.dart';
import 'package:shimmer/shimmer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final wishListController = Get.find<WishListController>();
  final settingsController = Get.find<SettingsController>();
  final loginController = Get.find<LoginController>();

  bool _shimmerEnable = true;

  customiseSystemOverlay(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light));
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isUserLoggedIn = false;
  bool wishListData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customiseSystemOverlay();
    checkUserFromShopify();
    waitForShimmerEffect();

    debugPrint("Last Incomplete Checkout *: ${loginController.currentUser.value?.lastIncompleteCheckout?.toJson().toString()}");
    // Future.delayed(const Duration(seconds: 2));
    // debugPrint('User **: $isUserLoggedIn');
    setState(() {
      wishListData = wishListController.favouritesList.value.isNotEmpty;
    });

  }

  Future<void> checkUserFromShopify() async{
    await loginController.checkUser().then((value) {
      debugPrint("User ID ***:${loginController.currentUser.value?.id}");
      if(loginController.currentUser.value?.id == null){
        debugPrint("User Not logged in ***");
        if(mounted){
          setState(() {
            isUserLoggedIn = false;
          });
        }
      }else{
        debugPrint("User logged in ***");
        if(mounted){
          setState(() {
            isUserLoggedIn = true;
          });
        }
      }
    });
  }
  Future<void> waitForShimmerEffect() async {
    await Future.delayed(
      const Duration(seconds: 2),
          () {
       if(mounted){
         setState(() {
           _shimmerEnable = false;
         });
       }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(width: 0.0),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(95.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0,bottom: 25),
                    child: Text(
                      'Settings',
                      style: AppStyle.gfPoppinsBoldWhite(fontSize: 40)
                    ),
                  ),
                ),
              ),
            ),
            key: scaffoldKey,
            // drawer: buildDrawer(context),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  // Container(
                  //   width: size.width,
                  //   height: 120,
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(20),
                  //       bottomRight: Radius.circular(20),),
                  //     color: Colors.black,
                  //
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 60.0, bottom: 15),
                  //         child: Text('Settings',
                  //           style: AppStyle.gfPoppinsBoldWhite(fontSize: 40),),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  _shimmerEnable
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      isUserLoggedIn
                          ? GestureDetector(
                        onTap: () {
                          debugPrint(
                              "Customer Access Token : ${loginController
                                  .userAccessToken.value.toString()} :");
                          Get.to(() => const ProfileScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          child: ListTile(
                            title: Shimmer.fromColors(
                              enabled: _shimmerEnable,
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 220,
                                height: 30,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Shimmer.fromColors(
                              enabled: _shimmerEnable,
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 220,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                          : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: InkWell(
                              onTap: () {
                                if (loginController.currentUser.value?.id ==
                                    null) {
                                  debugPrint(
                                      "User :${loginController.currentUser.value
                                          ?.displayName}: not logged in...");
                                  Get.to(() =>
                                  LoginPage(
                                    loginRoute: LoginRoute.settingsScreen,
                                  ));
                                } else {
                                  debugPrint(
                                      "User :${loginController.currentUser.value
                                          ?.displayName}: already logged in...");
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Shimmer.fromColors(
                                    enabled: _shimmerEnable,
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 80.0, right: 10),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),

                      // WishList Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/wishlistScreen');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                enabled: _shimmerEnable,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // Rating Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                enabled: _shimmerEnable,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // Privacy and Terms Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                enabled: _shimmerEnable,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // About Us Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/homeScreen2');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                enabled: _shimmerEnable,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      isUserLoggedIn
                          ? ElevatedButton(
                        onPressed: () async {
                          await loginController.signout().whenComplete(() {
                            Future.delayed(const Duration(seconds: 1));
                            setState(() {
                              isUserLoggedIn = false;
                            });
                            debugPrint(
                                'Log out successful : Access token : ${loginController
                                    .userAccessToken.value} :');
                            debugPrint(
                                ': User : ${loginController.currentUser.value
                                    ?.firstName ?? ''} :');
                          }).onError((error, stackTrace) {
                            showErrorMessage(error.toString());
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        child: Text(
                          'Log out',
                          style: AppStyle.gfPoppinsMediumWhite(fontSize: 19),
                        ),
                      )
                          : const Text(''),

                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  )
                      :Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                          isUserLoggedIn
                          ? GestureDetector(
                        onTap: () {
                          debugPrint(
                              "Customer Access Token : ${loginController
                                  .userAccessToken.value.toString()} :");
                          Get.to(() => const ProfileScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          child: ListTile(
                            title: Text(
                              '${loginController.currentUser.value
                                  ?.displayName}',
                              style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                            ),
                            subtitle: Text(
                              '${loginController.currentUser.value?.email}',
                              style: AppStyle.gfPoppinsMediumBlack(fontSize: 16),
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade400,
                                radius: 25,
                                child: GetX<LoginController>(
                                    builder: (controller) {
                                      return Text(
                                        '${controller.currentUser.value
                                            ?.firstName!
                                            .substring(0, 1).toString() ??
                                            ''}${controller.currentUser.value
                                            ?.lastName!
                                            .substring(0, 1)
                                            .toString() ?? ''}',
                                        style: AppStyle.gfPoppinsMediumBlack(
                                            fontSize: 18),
                                      );
                                    }),
                                // const Icon(
                                //   Icons.person,
                                //   size: 40,
                                //   color: Colors.black,
                                // ),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                          : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: InkWell(
                              onTap: () {
                                if (loginController.currentUser.value?.id ==
                                    null) {
                                  debugPrint(
                                      "User :${loginController.currentUser.value
                                          ?.displayName}: not logged in...");
                                  Get.to(() =>
                                  LoginPage(
                                    loginRoute: LoginRoute.settingsScreen,
                                  ));
                                } else {
                                  debugPrint(
                                      "User :${loginController.currentUser.value
                                          ?.displayName}: already logged in...");
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.person,
                                        size: 26,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 80.0, right: 10),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),

                      /*// general Settings Text
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'General Settings',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),*/
                      // WishList Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/wishlistScreen');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  GetX<WishListController>(
                                      builder: (controller) {
                                        return Icon(
                                          controller.itemsCount > 0
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: wishListData
                                              ? Colors.red
                                              : null,
                                          size: 28,
                                        );
                                      }),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const Text(
                                    'My Wishlist',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GetX<WishListController>(
                                      builder: (controller) {
                                        return Text(
                                          wishListController
                                              .favouritesList.value.isNotEmpty
                                              ? controller.itemsCount == 1
                                              ? '${controller
                                              .itemsCount} Product'
                                              : '${controller
                                              .itemsCount} Products'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: wishListData
                                                ? Colors.green
                                                : Colors.black,
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*// Divider
                            const Padding(
                              padding: EdgeInsets.only(left: 80.0, right: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            // notification Button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.notifications_none_outlined,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          'Get Notification',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      value: notificationSwitchIsEnabled,
                                      onChanged: (value) {
                                        setState(() {
                                          debugPrint(
                                              "notification Switch Value : $value");
                                          notificationSwitchIsEnabled = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // used to hide any widget
                            Offstage(
                              offstage: !notificationSwitchIsEnabled,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 80.0, right: 10),
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(()=>const NotificationsScreen());
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                FontAwesomeIcons.bars,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                'Notify Messages',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Divider
                            const Padding(
                              padding: EdgeInsets.only(left: 80.0, right: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            // Languages Button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .push(
                                  //       MaterialPageRoute(
                                  //           builder: (_) =>
                                  //               const LanguageSelectionScreen()),
                                  //     )
                                  //     .then((value) => _setLanguageName());
                                  Get.to(LanguageSelectionScreen())!
                                      .then((value) => _setLanguageName());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Flag.fromCode(
                                          flagCode,
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        const Text(
                                          'Languages',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          languageName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Divider
                            const Padding(
                              padding: EdgeInsets.only(left: 80.0, right: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            // Currency Button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .push(
                                  //       MaterialPageRoute(
                                  //           builder: (_) => CurrencySelectionScreen()),
                                  //     )
                                  //     .then((value) => _setCurrencyName());
                                  Get.to(CurrencySelectionScreen())!
                                      .then((value) => _setCurrencyName());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          currencyIcon,
                                          size: 26,
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        const Text(
                                          'Currencies',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          currencyName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      /*// Appearance Button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: InkWell(
                                onTap: () {
                                  themeNotifier.isDark
                                      ? themeNotifier.isDark = false
                                      : themeNotifier.isDark = true;
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.nights_stay,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "Dark Mode",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    Switch(value: themeNotifier.isDark, onChanged: (value){
                                      setState(() {
                                        themeNotifier.isDark
                                            ? themeNotifier.isDark = value
                                            : themeNotifier.isDark = value;
                                      });
                                    }),

                                  ],
                                ),
                              ),
                            ),
                            // Divider
                            const Padding(
                              padding: EdgeInsets.only(left: 80.0, right: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),*/
                      // Rating Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star_border_outlined,
                                    size: 26,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Rate the app',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // Privacy and Terms Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const NewCheckoutDesignScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    FontAwesomeIcons.fileLines,
                                    size: 26,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Privacy and Terms',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // About Us Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/homeScreen2');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.report_gmailerrorred,
                                    size: 26,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'About Us',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      isUserLoggedIn
                          ? ElevatedButton(
                        onPressed: () async {
                          await loginController.signout().whenComplete(() {
                            Future.delayed(const Duration(seconds: 1));
                            setState(() {
                              isUserLoggedIn = false;
                            });
                            debugPrint(
                                'Log out successful : Access token : ${loginController
                                    .userAccessToken.value} :');
                            debugPrint(
                                ': User : ${loginController.currentUser.value
                                    ?.firstName ?? ''} :');
                          }).onError((error, stackTrace) {
                            showErrorMessage(error.toString());
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        child: Text(
                          'Log out',
                          style: AppStyle.gfPoppinsMediumWhite(fontSize: 19),
                        ),
                      )
                          : const Text(''),

                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Image(
                      image: AssetImage('assets/images/shopify.png'),
                      fit: BoxFit.fill,
                      width: 55,
                      height: 55,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Lime Light Store",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1.1,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.home),
              title: const Text(' Home '),
              onTap: () {
                Get.off(MainScreen(selectedIndex: 0));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Blog '),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: const Text(' Categories '),
              onTap: () {
                Get.off(MainScreen(selectedIndex: 1));
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.bag),
              title: const Text(' Cart '),
              onTap: () {
                Get.off(MainScreen(selectedIndex: 3));
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.settings),
              title: const Text(' Settings'),
              onTap: () {
                // Navigator.pop(context);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ));
  }
}

/*
CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              backgroundColor: Colors.black,
              floating: true,
              pinned: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              actionsIconTheme: const IconThemeData(opacity: 0.0),
              flexibleSpace: Stack(
                children: const <Widget>[
                  Positioned(
                    bottom: 20,
                    left: 65,
                    child: Text(
                      'Settings',
                      style: TextStyle(color: Colors.white, fontSize: 38),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 40,
                  ),

                  isUserLoggedIn
                      ? GestureDetector(
                          onTap: () {
                            debugPrint(
                                "Customer Access Token : ${loginController.userAccessToken.value.toString()} :");
                            Get.to(() => const ProfileScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20),
                            child: ListTile(
                              title: Text(
                                '${loginController.currentUser.value?.displayName}',
                                style: AppStyle.txtPoppinsMedium20,
                              ),
                              subtitle: Text(
                                '${loginController.currentUser.value?.email}',
                                style: AppStyle.txtPoppinsSemiBold16,
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade400,
                                  radius: 25,
                                  child: GetX<LoginController>(
                                      builder: (controller) {
                                    return Text(
                                      '${controller.currentUser.value?.firstName!.substring(0, 1).toString() ?? ''}${controller.currentUser.value?.lastName!.substring(0, 1).toString() ?? ''}',
                                      style: AppStyle.gfPoppinsMediumBlack(
                                          fontSize: 18),
                                    );
                                  }),
                                  // const Icon(
                                  //   Icons.person,
                                  //   size: 40,
                                  //   color: Colors.black,
                                  // ),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: InkWell(
                                onTap: () {
                                  if (loginController.currentUser.value?.id ==
                                      null) {
                                    debugPrint(
                                        "User :${loginController.currentUser.value?.displayName}: not logged in...");
                                    Get.to(() => const LoginPage(
                                          loginRoute: LoginRoute.settingsScreen,
                                        ));
                                  } else {
                                    debugPrint(
                                        "User :${loginController.currentUser.value?.displayName}: already logged in...");
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.person,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 80.0, right: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),

    //general Settings Text
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'General Settings',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  // WishList Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/wishlistScreen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              GetX<WishListController>(builder: (controller) {
                                return Icon(
                                  controller.itemsCount > 0
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: wishListData ? Colors.red : null,
                                  size: 28,
                                );
                              }),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                'My Wishlist',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GetX<WishListController>(builder: (controller) {
                                return Text(
                                  wishListController
                                          .favouritesList.value.isNotEmpty
                                      ? controller.itemsCount == 1
                                          ? '${controller.itemsCount} Product'
                                          : '${controller.itemsCount} Products'
                                      : '',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: wishListData
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                );
                              }),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // notification Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.notifications_none_outlined,
                                    size: 26,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Get Notification',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                value: notificationSwitchIsEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    debugPrint(
                                        "notification Switch Value : $value");
                                    notificationSwitchIsEnabled = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // used to hide any widget
                      Offstage(
                        offstage: !notificationSwitchIsEnabled,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 80.0, right: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 5.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(()=>const NotificationsScreen());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.bars,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          'Notify Messages',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // Languages Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context)
                            //     .push(
                            //       MaterialPageRoute(
                            //           builder: (_) =>
                            //               const LanguageSelectionScreen()),
                            //     )
                            //     .then((value) => _setLanguageName());
                            Get.to(LanguageSelectionScreen())!
                                .then((value) => _setLanguageName());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Flag.fromCode(
                                    flagCode,
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const Text(
                                    'Languages',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    languageName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      // Currency Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context)
                            //     .push(
                            //       MaterialPageRoute(
                            //           builder: (_) => CurrencySelectionScreen()),
                            //     )
                            //     .then((value) => _setCurrencyName());
                            Get.to(CurrencySelectionScreen())!
                                .then((value) => _setCurrencyName());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    currencyIcon,
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const Text(
                                    'Currencies',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    currencyName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  // Divider
                  const Padding(
                    padding: EdgeInsets.only(left: 80.0, right: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Appearance Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            themeNotifier.isDark
                                ? themeNotifier.isDark = false
                                : themeNotifier.isDark = true;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.nights_stay,
                                    size: 26,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "Dark Mode",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Switch(value: themeNotifier.isDark, onChanged: (value){
                                setState(() {
                                  themeNotifier.isDark
                                      ? themeNotifier.isDark = value
                                      : themeNotifier.isDark = value;
                                });
                              }),

                            ],
                          ),
                        ),
                      ),
                      // Divider
                      const Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                  // Rating Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.star_border_outlined,
                                size: 26,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'Rate the app',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider
                  const Padding(
                    padding: EdgeInsets.only(left: 80.0, right: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  // Privacy and Terms Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.fileLines,
                                size: 26,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'Privacy and Terms',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider
                  const Padding(
                    padding: EdgeInsets.only(left: 80.0, right: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  // About Us Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.report_gmailerrorred,
                                size: 26,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'About Us',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider
                  const Padding(
                    padding: EdgeInsets.only(left: 80.0, right: 10),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  isUserLoggedIn
                      ? ElevatedButton(
                          onPressed: () async {
                            await loginController.signout().whenComplete(() {
                              Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                isUserLoggedIn = false;
                              });
                              debugPrint(
                                  'Log out successful : Access token : ${loginController.userAccessToken.value} :');
                              debugPrint(
                                  ': User : ${loginController.currentUser.value?.firstName ?? ''} :');
                            }).onError((error, stackTrace) {
                              showErrorMessage(error.toString());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(150, 40),
                          ),
                          child: Text(
                            'Log out',
                            style: AppStyle.txtPoppinsMedium19,
                          ),
                        )
                      : const Text(''),

                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }*/


