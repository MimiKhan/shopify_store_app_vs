import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/customer_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/profile/profile_order_details_screen.dart';

class ProfileMyOrdersScreen extends StatefulWidget {
  const ProfileMyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMyOrdersScreen> createState() => _ProfileMyOrdersScreenState();
}

class _ProfileMyOrdersScreenState extends State<ProfileMyOrdersScreen> {
  final customerController = Get.find<CustomerController>();
  final loginController = Get.find<LoginController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerController
        .getCustomersOrders(loginController.userAccessToken.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders',
              style: AppStyle.gfPoppinsBoldBlack(fontSize: 24),
            ),
            customerController.ordersList.isEmpty?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 35.0),
                    child: Text('No Orders Yet',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offNamed('/mainScreen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Start Shopping',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
            :ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                 scrollDirection: Axis.vertical,
                itemCount: customerController.ordersList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(() => ProfileOrderDetailsScreen(order: customerController.ordersList[index]));
                    },
                    child: ListTile(
                      subtitle: GetX<CustomerController>(
                          builder: (controller) {
                            return Text(
                                controller.ordersList[index].totalPriceV2.formattedPrice);
                          }
                      ),
                      title: GetX<CustomerController>(
                          builder: (controller) {
                            return Text(
                                controller.ordersList[index].totalPriceV2.formattedPrice);
                          }
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
