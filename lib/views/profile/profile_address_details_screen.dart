import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/customer_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/profile/profile_add_address_screen.dart';

class ProfileAddressDetailScreen extends StatefulWidget {
  const ProfileAddressDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAddressDetailScreen> createState() =>
      _ProfileAddressDetailScreenState();
}

class _ProfileAddressDetailScreenState
    extends State<ProfileAddressDetailScreen> {
  final loginController = Get.find<LoginController>();
  final customerController = Get.find<CustomerController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(
        "Address List length *: ${loginController.addressList.value.length}");
    var list = loginController.addressList.value;
    for (var e in list) {
      debugPrint("ID **: ${e.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    debugPrint("${size.width} x ${size.height}");
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => ProfileAddAddressScreen(
                        address: Address(),
                        addressType: AddressType.newAddress));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Add New',
                    style: AppStyle.gfPoppinsMediumWhite(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Current Addresses',
              style: AppStyle.gfPoppinsBoldBlack(fontSize: 24),
            ),
            loginController.currentUser.value?.address?.addressList.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 35.0),
                          child: Text('No Address Found',
                              style:
                                  AppStyle.gfPoppinsRegularBlack(fontSize: 22)),
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => ProfileAddAddressScreen(
                                  address: Address(),
                                  addressType: AddressType.newAddress));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              'Add New Address',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : GetX<LoginController>(builder: (controller) {
                    return SizedBox(
                      height: 360,
                      child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.addressList.value.length,
                          // padding: const EdgeInsets.only(top: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                width: size.width - 21,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey.shade200,
                                  border: Border.all(
                                      color: Colors.black26, width: 1.3),
                                ),
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: [
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Get.to(
                                                  () => ProfileAddAddressScreen(
                                                        address: (controller
                                                            .addressList
                                                            .value[index]),
                                                        addressType: AddressType
                                                            .editAddress,
                                                      ));
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.pen,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  'Edit',
                                                  style: AppStyle
                                                      .gfPoppinsRegularBlack(
                                                          fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              bool confirm =
                                                  await _confirmDelete();
                                              if (confirm) {
                                                // Delete the product
                                                debugPrint("Pressed Confirm");
                                                var address = controller.addressList.value[index];
                                                customerController
                                                    .deleteCustomerAddress(
                                                        userToken: controller
                                                            .userAccessToken
                                                            .value
                                                            .toString(),
                                                        addressId: controller
                                                                .addressList
                                                                .value[index]
                                                                .id ??
                                                            '')
                                                    .then((value) {
                                                      controller.addressList.value.remove(address);
                                                      Fluttertoast.showToast(msg: 'Address Deleted successful.');
                                                }).onError((error, stackTrace) {
                                                  showErrorMessage(
                                                      error.toString());
                                                });
                                              } else {
                                                debugPrint("Pressed Cancel");
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.delete,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  'Remove',
                                                  style: AppStyle
                                                      .gfPoppinsRegularBlack(
                                                          fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   '${loginController.currentUser.value?.address?.addressList[index].id} ',
                                            //   style: AppStyle.txtMontserratMedium15,
                                            // ),
                                            Text(
                                              '${controller.addressList.value[index].firstName} '
                                              '${controller.addressList.value[index].lastName}',
                                              style:
                                                  AppStyle.gfPoppinsMediumBlack(
                                                      fontSize: 16),
                                            ),
                                            controller
                                                        .currentUser
                                                        .value
                                                        ?.address
                                                        ?.addressList[index]
                                                        .address2 !=
                                                    null
                                                ? Text(
                                                    '${controller.addressList.value[index].address1},'
                                                    ' ${controller.addressList.value[index].city},'
                                                    ' ${controller.addressList.value[index].province},'
                                                    ' ${controller.addressList.value[index].country},'
                                                    ' ${controller.addressList.value[index].zip}.',
                                                    style: AppStyle
                                                        .gfPoppinsMediumBlack(
                                                            fontSize: 15),
                                                    softWrap: true,
                                                  )
                                                : Text(
                                                    '${controller.addressList.value[index].address1},'
                                                    ' ${controller.addressList.value[index].address2},'
                                                    ' ${controller.addressList.value[index].city},'
                                                    ' ${controller.addressList.value[index].province},'
                                                    ' ${controller.addressList.value[index].country},'
                                                    ' ${controller.addressList.value[index].zip}.',
                                                    style: AppStyle
                                                        .gfPoppinsMediumBlack(
                                                            fontSize: 15),
                                                    softWrap: true,
                                                  ),
                                            Text(
                                              '${controller.addressList.value[index].phone}',
                                              style:
                                                  AppStyle.gfPoppinsMediumBlack(
                                                      fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                /*child: Column(
                                  children: [
                                    // Address name and Edit Button
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${loginController.currentUser?.address?.addressList[index].name}'),
                                          TextButton(
                                            onPressed: () {},
                                            child: Row(
                                              children: const [
                                                Icon(CupertinoIcons.pen),
                                                Text('Edit'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    // First and Last Name
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Name',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].firstName} ${loginController.currentUser?.address?.addressList[index].lastName}',
                                            style: AppStyle.txtMontserratMedium15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Address 1
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Address 1',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].address1.toString()}',
                                            style: AppStyle.txtMontserratMedium15,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Address 2
                                    Offstage(
                                      offstage: loginController.currentUser?.address
                                              ?.addressList[index].address2 ==
                                          null,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Address 2',
                                              style: AppStyle.txtLatoRegular15,
                                            ),
                                            Text(
                                              '${loginController.currentUser?.address?.addressList[index].address2}',
                                              style: AppStyle.txtMontserratMedium15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // City
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'City',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].city}',
                                            style: AppStyle.txtMontserratMedium15,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Province
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Province/State',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].province} ${loginController.currentUser?.address?.addressList[index].provinceCode ?? ''}',
                                            style: AppStyle.txtMontserratMedium15,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Country
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Country',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].country} ${loginController.currentUser?.address?.addressList[index].countryCode?? ''}',
                                            style: AppStyle.txtMontserratMedium15,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Zip
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Zip Code',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].zip}',
                                            style: AppStyle.txtMontserratMedium15,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Phone
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Phone #',
                                            style: AppStyle.txtLatoRegular15,
                                          ),
                                          Text(
                                            '${loginController.currentUser?.address?.addressList[index].phone}',
                                            style: AppStyle.txtMontserratMedium15,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),*/
                              ),
                            );
                          }),
                    );
                  }),
          ],
        ),
      ),
    );
  }

  Future _confirmDelete() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            OutlinedButton(
              child: const Text('DELETE'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
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
}
