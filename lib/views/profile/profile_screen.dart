import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/core/utils/color_constant.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';
import 'package:shopify_store_app/views/profile/profile_address_details_screen.dart';
import 'package:shopify_store_app/views/profile/profile_info_screen.dart';
import 'package:shopify_store_app/views/profile/profile_my_orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin{
  final loginController = Get.find<LoginController>();
  
  late TabController controller;

  Future<void> refreshData()async{
    await Future.delayed(const Duration(seconds: 3), () {
      loginController.currentUser.value = null;
      updateUser();
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("user AT *: ${loginController.userAccessToken.value}");
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      animationDuration: const Duration(seconds: 2),
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, // set the color of the back icon here
          ),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            IconButton(onPressed: ()async{
              debugPrint(
                  ': User : ${loginController.currentUser.value?.firstName ?? ''} :');
              await loginController.signout().then((value) {
                debugPrint(
                    'Log out successful : Access token : ${loginController.userAccessToken.value} : ');
                Get.to(()=> MainScreen(selectedIndex: 4));
              }).onError((error, stackTrace) {
                debugPrintStack(stackTrace: stackTrace);
                showErrorMessage(error.toString());
              });

            }, icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 172,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GetX<LoginController>(
                        builder: (controller) {
                          return Text(
                            '${controller.currentUser.value?.displayName}',
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (loginController.currentUser.value?.address?.addressList.length == 0)
                        const Text('No Address here')
                      else
                        GetX<LoginController>(
                          builder: (controller) {
                            return Text(
                                '${controller.currentUser.value?.address?.addressList.first.city}, '
                                    '${controller.currentUser.value?.address?.addressList.first.country}');
                          }
                        ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 40,
                  endIndent: 40,
                  color: Colors.black,
                  thickness: 1.2,
                ),

                Container(
                  width: size.width,
                  margin: const EdgeInsets.only(top: 18),
                  child: TabBar(
                    controller: controller,
                    tabs: const [
                      Tab(
                        text: "Profile Info",
                      ),
                      Tab(
                        text: "My Orders",
                      ),
                      Tab(
                        text: "Addresses",
                      ),
                    ],
                    labelColor: ColorConstant.indigoA200,
                    unselectedLabelColor: ColorConstant.gray600,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    top: 36,
                    right: 16,
                    bottom: 49,
                  ),
                  width: size.width,
                  height: size.height,
                  child: TabBarView(
                    controller: controller,
                    children:  [
                      ProfileInfoScreen(),
                      const ProfileMyOrdersScreen(),
                      const ProfileAddressDetailScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  void updateUser() {
    loginController.checkUser();
  }
}
