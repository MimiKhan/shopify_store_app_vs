import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/core/utils/custom_icons.dart';
import 'package:shopify_store_app/new_ui_designs/cart_screen/cart_screen_new_design.dart';
import 'package:shopify_store_app/new_ui_designs/home_screen/ui/home_screen_ui.dart';
import 'package:shopify_store_app/services/hex_color.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/cart/cart_ui/cart_screen2.0.dart';
import 'package:shopify_store_app/views/categories/collections_screen.dart';
import 'package:shopify_store_app/views/home_ui/home_screen.dart';
import 'package:shopify_store_app/views/others/tablet_view_screen.dart';
import 'package:shopify_store_app/views/search/search_screen.dart';
import 'package:shopify_store_app/views/settings/settings_screen.dart';

import 'bottom_tabs.dart';

class MainScreen extends StatefulWidget {
  int selectedIndex = 0;

  MainScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  // For Google Nav Bar
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  final cartController = Get.find<CartController>();

  var pagesList = [
    const HomeScreenUI(),
    const CategoryScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _bottomNavIndex = widget.selectedIndex;
      debugPrint("Selected Index of Screen from Bottom : $_bottomNavIndex");
    });
  }

  @override
  void initState() {
    super.initState();

    _onItemTapped(widget.selectedIndex);

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  var items = [
    TabNavigationItem(
      page: const HomeScreen(),
      icon: const Icon(Icons.home),
      title: const Text("Home"),
    ),
    TabNavigationItem(
      page: const CategoryScreen(),
      icon: const Icon(Icons.category),
      title: const Text("Category"),
    ),
    TabNavigationItem(
      page: const SearchScreen(),
      icon: const Icon(CupertinoIcons.search),
      title: const Text("Search"),
    ),
    TabNavigationItem(
      page: CartScreen2(),
      icon: badges.Badge(
        showBadge: true,
        position: badges.BadgePosition.topEnd(top: 0, end: 3),
        badgeAnimation: const badges.BadgeAnimation.rotation(
          animationDuration: Duration(seconds: 3),
          colorChangeAnimationDuration: Duration(seconds: 1),
          loopAnimation: false,
          curve: Curves.fastOutSlowIn,
          colorChangeAnimationCurve: Curves.easeInCubic,
        ),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.square,
          badgeColor: Colors.blue,
          padding: const EdgeInsets.all(5),
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderGradient: const badges.BadgeGradient.linear(
              colors: [Colors.red, Colors.black]),
          badgeGradient: const badges.BadgeGradient.linear(
            colors: [Colors.blue, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          elevation: 0,
        ),
        badgeContent: GetX<CartController>(builder: (controller) {
          return Text(controller.cartModelItemsCount.toString());
        }),
        child: const Icon(CustomIcons.cart),
      ),
      title: const Text("Cart"),
    ),
    TabNavigationItem(
      page: const SettingScreen(),
      icon: const Icon(CupertinoIcons.settings),
      title: const Text("Settings"),
    ),
  ];

  final List<IconData> _icons = [
    CupertinoIcons.home,
    CustomIcons.collections,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: size.width > 600
            ? const TabletViewScreen()
            : _buildAnimatedNavBar(),
        floatingActionButton: Container(
          width: 56.0,
          height: 56.0,
          child: badges.Badge(
            badgeContent: GetX<CartController>(builder: (controller) {
              return Text(
                '${controller.cartModelItemsCount}',
                style: AppStyle.gfPoppinsMediumWhite(fontSize: 14),
              );
            }),
            position: BadgePosition.topEnd(top: -10, end: 0),
            badgeStyle: badges.BadgeStyle(
              badgeColor: HexColor("#D35F5F"),
              shape: badges.BadgeShape.circle,
              padding: const EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FloatingActionButton(
              onPressed: () {
                _navigateToCartScreen();
              },
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              child: const Icon(
                CustomIcons.cart,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: size.width > 600
            ? const TabletViewScreen()
            : pagesList[widget.selectedIndex]);
  }

  _navigateToCartScreen() {
    // Get.to(() => CartScreen2());
    Get.to(() => const NewCartScreen());
  }

  // buildNavigationBar() {
  //   return BottomNavigationBar(
  //     iconSize: 35,
  //     elevation: 0,
  //     showSelectedLabels: true,
  //     selectedItemColor: HexColor('#F47B68'),
  //     unselectedItemColor: HexColor('#687eaf'),
  //     type: BottomNavigationBarType.fixed,
  //     showUnselectedLabels: true,
  //     items: [
  //       const BottomNavigationBarItem(
  //         icon: Icon(
  //           CupertinoIcons.home,
  //         ),
  //         label: "Home",
  //       ),
  //       const BottomNavigationBarItem(
  //         icon: Icon(
  //           CupertinoIcons.collections,
  //         ),
  //         label: "Collections",
  //       ),
  //       // const BottomNavigationBarItem(
  //       //   icon: Icon(
  //       //     CupertinoIcons.search,
  //       //   ),
  //       //   label: "Search",
  //       // ),
  //       // BottomNavigationBarItem(
  //       //   icon: Stack(children: <Widget>[
  //       //     const Icon(CupertinoIcons.bag),
  //       //     Positioned(
  //       //         top: -5.0,
  //       //         right: 1.0,
  //       //         child: Stack(
  //       //           children: <Widget>[
  //       //             badges.Badge(
  //       //               badgeContent: GetX<CartController>(builder: (controller) {
  //       //                 return Text(
  //       //                   controller.cartModelItemsCount.toString(),
  //       //                   style: const TextStyle(color: Colors.white),
  //       //                 );
  //       //               }),
  //       //               showBadge: true,
  //       //               ignorePointer: true,
  //       //               badgeStyle: badges.BadgeStyle(
  //       //                 shape: badges.BadgeShape.circle,
  //       //                 badgeColor: Colors.black,
  //       //                 padding: const EdgeInsets.all(5),
  //       //                 borderRadius: BorderRadius.circular(4),
  //       //                 borderSide:
  //       //                     const BorderSide(color: Colors.white, width: 2),
  //       //                 // badgeGradient: const badges.BadgeGradient.linear(
  //       //                 //   colors: [Colors.blue, Colors.yellow],
  //       //                 //   begin: Alignment.topCenter,
  //       //                 //   end: Alignment.bottomCenter,
  //       //                 // ),
  //       //                 elevation: 0,
  //       //               ),
  //       //               // badgeAnimation: const badges.BadgeAnimation.fade(
  //       //               //   animationDuration: Duration(seconds: 3),
  //       //               //   toAnimate: true,
  //       //               //   // colorChangeAnimationDuration: Duration(seconds: 2),
  //       //               //   disappearanceFadeAnimationDuration:
  //       //               //       Duration(seconds: 1),
  //       //               //   loopAnimation: true,
  //       //               //   curve: Curves.elasticInOut,
  //       //               //   // colorChangeAnimationCurve: Curves.easeInCubic,
  //       //               // ),
  //       //             ),
  //       //           ],
  //       //         ))
  //       //   ]),
  //       //   label: "Bag",
  //       // ),
  //       const BottomNavigationBarItem(
  //         icon: Icon(
  //           CupertinoIcons.settings,
  //         ),
  //         label: "Settings",
  //       ),
  //     ],
  //     onTap: _onItemTapped,
  //     currentIndex: widget.selectedIndex,
  //   );
  // }

  _buildAnimatedNavBar() {
    return AnimatedBottomNavigationBar(
      activeColor: HexColor("#D35F5F"),
      icons: _icons,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.end,
      notchSmoothness: NotchSmoothness.defaultEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 0, // Set rightCornerRadius to 0
      onTap: (index) => setState(() => _bottomNavIndex = index),
      backgroundColor: Colors.white,
      elevation: 8,
      iconSize: 24.0,
    );
  }
}
