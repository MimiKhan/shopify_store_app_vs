import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/customer_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/core/utils/color_constant.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';
import 'package:shopify_store_app/theme/app_style.dart';

enum AddressType { newAddress, editAddress }

class ProfileAddAddressScreen extends StatefulWidget {
  final Address? address;
  final AddressType addressType;

  const ProfileAddAddressScreen(
      {Key? key, required this.address, required this.addressType})
      : super(key: key);

  @override
  State<ProfileAddAddressScreen> createState() =>
      _ProfileAddAddressScreenState();
}

class _ProfileAddAddressScreenState extends State<ProfileAddAddressScreen> {
  final loginController = Get.find<LoginController>();
  final customerController = Get.find<CustomerController>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();

  var address;
  var addressIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('${widget.addressType}');
    if (widget.addressType == AddressType.editAddress) {
      debugPrint("Address *: ${widget.address?.id}");
      addressIndex = loginController.currentUser.value?.address?.addressList
          .indexWhere((element) => element.id == widget.address?.id);
      debugPrint("Address Index **: $addressIndex");

      _firstNameController.text = '${widget.address?.firstName}';
      _lastNameController.text = '${widget.address?.lastName}';
      _address1Controller.text = '${widget.address?.address1}';
      _address2Controller.text = '${widget.address?.address2}';
      _cityController.text = '${widget.address?.city}';
      _provinceController.text = '${widget.address?.province}';
      _countryController.text = '${widget.address?.country}';
      _zipController.text = '${widget.address?.zip}';
      _phoneController.text = '${widget.address?.phone}';
    } else if (widget.addressType == AddressType.newAddress) {
      _firstNameController.text = 'Mimi';
      _lastNameController.text = 'Khan';
      _address1Controller.text = 'Chak # 91/9-L Arifwala road';
      _address2Controller.text = 'Opposite M.A. Foods';
      _cityController.text = 'Sahiwal';
      _provinceController.text = 'Punjab';
      _countryController.text = 'Pakistan';
      _zipController.text = '57000';
      _phoneController.text = '+923009691591';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // set the color of the back icon here
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Add Address',
          style: AppStyle.gfPoppinsBoldWhite(fontSize: 18),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '* Please provide required information to add new/edit address.',
                style: AppStyle.gfPoppinsBoldBlack(fontSize: 12),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _firstNameController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'First Name',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _lastNameController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Last Name',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _address1Controller,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Address',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.streetAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _address2Controller,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Apartment, suite etc (Optional)',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.streetAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _cityController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'City',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _provinceController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Province / State',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _countryController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Country',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _zipController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Zip Code',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 51,
                  height: 50,
                  child: TextField(
                    controller: _phoneController,
                    style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                    decoration: InputDecoration(
                      label: Text(
                        'Phone Number',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                      ),
                      filled: true,
                      fillColor: ColorConstant.gray100,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1.2, color: ColorConstant.black900)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(maxWidth: 380, maxHeight: 60),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width - 101,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          shadowColor: ColorConstant.blueGray100),
                      onPressed: () async {
                        String firstName = _firstNameController.text;
                        String lastName = _lastNameController.text;
                        String address1 = _address1Controller.text;
                        String address2 = _address2Controller.text;
                        String city = _cityController.text;
                        String province = _provinceController.text;
                        String country = _countryController.text;
                        String zip = _zipController.text;
                        String phone = _phoneController.text;
                        String accessToken =
                            loginController.userAccessToken.value.toString();
                        String addressId = widget.address?.id.toString() ?? '';

                        if (widget.addressType == AddressType.newAddress) {
                          address = await customerController
                              .addCustomerAddress(
                                  firstName: firstName,
                                  lastName: lastName,
                                  address1: address1,
                                  address2: address2,
                                  city: city,
                                  country: country,
                                  province: province,
                                  zip: zip,
                                  phone: phone,
                                  customerAccessToken: accessToken)
                              .then((value) {
                            showDoneDialog(
                                "You have successfully added your address.");
                            try{
                              loginController.addressList.value.add(value);

                              // loginController.checkUser();
                            }catch(e){
                              debugPrint('------>$e');
                            }
                          }).onError((error, stackTrace) {
                            debugPrint("Error : ${error.toString()}:");
                            showErrorMessage(error.toString());
                          });
                        } else if (widget.addressType ==
                            AddressType.editAddress) {
                          await customerController
                              .updateCustomerAddress(
                                  addressId: addressId,
                                  firstName: firstName,
                                  lastName: lastName,
                                  address1: address1,
                                  address2: address2,
                                  city: city,
                                  country: country,
                                  province: province,
                                  zip: zip,
                                  phone: phone,
                                  userToken: accessToken)
                              .then((value) {
                            // await loginController.checkUser();
                            // loginController.update();
                            // loginController.currentUser.value?.address
                            //         ?.addressList[addressIndex] ==
                            //     Address(
                            //         firstName: firstName,
                            //         lastName: lastName,
                            //         address1: address1,
                            //         address2: address2,
                            //         city: city,
                            //         country: country,
                            //         province: province,
                            //         zip: zip,
                            //         phone: phone);
                            showDoneDialog(
                                "You have successfully updated your address.");
                          }).onError((error, stackTrace) {
                            debugPrint("Error : ${error.toString()}:");
                            showErrorMessage(error.toString());
                          });
                        }
                      },
                      child: widget.addressType == AddressType.newAddress
                          ? Text(
                              'Add Address',
                              style:
                                  AppStyle.gfPoppinsMediumWhite(fontSize: 26),
                            )
                          : Text(
                              'Update',
                              style:
                                  AppStyle.gfPoppinsMediumWhite(fontSize: 26),
                            )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDoneDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Get.offNamed('/profileScreen');
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
