import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';
import 'package:shopify_store_app/models/cart_model.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/cart/cart_ui/cart_screen2.0.dart';
import 'package:shopify_store_app/views/checkout/my_web_view_checkout.dart';

enum PreCheckoutUserType { user, guest }

class PreCheckoutScreen extends StatefulWidget {
  const PreCheckoutScreen({Key? key, required this.cartModelItems})
      : super(key: key);

  final List<CartModel> cartModelItems;

  @override
  State<PreCheckoutScreen> createState() => _PreCheckoutScreenState();
}

class _PreCheckoutScreenState extends State<PreCheckoutScreen> {
  final checkoutController = Get.find<CheckoutController>();
  final cartController = Get.find<CartController>();
  final loginController = Get.find<LoginController>();

  // String _firstName = 'Haider',
  //     _lastName = 'Khan',
  //     _address = 'Flat 4 103 Huddleston road',
  //     _city = 'London',
  //     _province = 'London',
  //     _country = 'United Kingdom',
  //     _zip = 'N70EH',
  //     _phone = '+447576298713';
  //
  // String _dialCode = '+44 ';
  //
  // final _firstNameController = TextEditingController(text: "Haider");
  // final _lastNameController = TextEditingController(text: "Khan");
  // final _addressController =
  //     TextEditingController(text: "Flat 4 103 Huddleston road");
  // final _cityController = TextEditingController(text: "London");
  // final _provinceController = TextEditingController(text: "London");
  // final _zipController = TextEditingController(text: "N70EH");
  // final _countryController = TextEditingController(text: "United Kingdom");
  // final _phoneController = TextEditingController(text: "7576298713");

  int _selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.off(() => CartScreen2()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                CupertinoIcons.arrowtriangle_left_fill,
                color: Colors.black,
              ),
              Text('Cart'),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              // debugPrint("""
              //               firstName: ${_firstNameController.text},$_firstName,
              //                   lastName: ${_lastNameController.text},
              //                   address1: ${_addressController.text},
              //                   city: ${_cityController.text},
              //                   country: $_country,
              //                   zip: ${_zipController.text},
              //                   phone: $_phone
              //                   """);
              var lineItems = await cartController
                  .getLineItems(cartController.cartModelItems.value);
              var address1 = loginController.addressList.value[_selectedIndex];
              await checkoutController
                  .createCheckoutFromCartWithAddress(lineItems, address1,loginController.userAccessToken.value)
                  .whenComplete(() {
                Get.to(() =>
                    WebViewScreen(
                        checkoutUrl: checkoutController.checkout.webUrl ?? ''));
                // Get.toNamed('/shippingSelect');
                // Get.toNamed('/checkoutScreen');
              }).onError((error, stackTrace) {
                debugPrint('------* In Checkout*--- > $error   <----*');
                debugPrintStack(stackTrace: stackTrace);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Proceed'),
                Icon(
                  CupertinoIcons.arrowtriangle_right_fill,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                    'Customer Information',
                    style: AppStyle.gfPoppinsBoldBlack(fontSize: 24),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                // height: 350,
                child: ListView.builder(
                  itemCount: loginController.addressList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    Address address = loginController.addressList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          // color: Colors.grey.shade200,
                        ),
                        child: RadioListTile(
                          tileColor: Colors.grey.shade200,
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${address.firstName} '
                                    '${address.lastName}',
                                style:
                                AppStyle.gfPoppinsMediumBlack(fontSize: 15),
                              ),
                              address.address2 != null
                                  ? Text(
                                '${address.address1},'
                                    ' ${address.city},'
                                    ' ${address.province},'
                                    ' ${address.country},'
                                    ' ${address.zip}.',
                                style: AppStyle.gfPoppinsMediumBlack(
                                    fontSize: 13),
                                softWrap: true,
                              )
                                  : Text(
                                '${address.address1},'
                                    ' ${address.address2},'
                                    ' ${address.city},'
                                    ' ${address.province},'
                                    ' ${address.country},'
                                    ' ${address.zip}.',
                                style: AppStyle.gfPoppinsMediumBlack(
                                    fontSize: 13),
                                softWrap: true,
                              ),
                              Text(
                                '${address.phone}',
                                style:
                                AppStyle.gfPoppinsMediumBlack(fontSize: 14),
                              ),
                            ],
                          ),
                          selectedTileColor: Colors.blueGrey.shade600,
                          value: index,
                          groupValue: _selectedIndex,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedIndex = value!;
                              debugPrint(
                                  "Selected Address : ${loginController
                                      .addressList.value[_selectedIndex]}");
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

/*
        SizedBox(
                width: 380,
                height: 45,
                child: GetX<CartController>(builder: (nestedCartController) {
                  var countryNames = nestedCartController.countryData
                      .map((element) => element.name!)
                      .toList();

                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return countryNames.where((item) {
                        return item
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (item) {
                      setState(() {
                        _country = item;
                        debugPrint("Country : $_country");
                        int index = nestedCartController.countryData
                            .indexWhere((element) => element.name == item);
                        _dialCode =
                            '${nestedCartController.countryData[index].dialCode!} ';
                        debugPrint('Data : $_dialCode : ');
                      });
                    },
                    initialValue: _countryController.value,
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      return TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(),
                          labelText: 'Country',
                        ),
                        style: const TextStyle(fontSize: 17),
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Country';
                          }
                          return null;
                        },
                        onChanged: (value) => _country = value,
                      );
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                  controller: _firstNameController,
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _firstName = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChanged: (value) => _lastName = value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                  keyboardType: TextInputType.streetAddress,
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your complete address.';
                    }
                    return null;
                  },
                  onChanged: (value) => _address = value,
                ),
              ),
              // const SizedBox(height: 20,),
              // SizedBox(
              //   width: 380,
              //   height: 45,
              //   child: TextFormField(
              //     decoration: const InputDecoration(
              //       enabledBorder: OutlineInputBorder(),
              //       disabledBorder: OutlineInputBorder(),
              //       focusedBorder: OutlineInputBorder(),
              //       focusedErrorBorder: OutlineInputBorder(),
              //       labelText: 'Address 2',
              //     ),
              //     keyboardType: TextInputType.streetAddress,
              //     controller: _address2EditingController,
              //     style: const TextStyle(fontSize: 17),
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Please enter your address.';
              //       }
              //       return value;
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your City';
                    }
                    return null;
                  },
                  onChanged: (value) => _city = value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  controller: _provinceController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelText: 'Province',
                  ),
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Province';
                    }
                    return null;
                  },
                  onChanged: (value) => _province = value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  controller: _zipController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelText: 'Zip Code',
                  ),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your City';
                    }
                    return null;
                  },
                  onChanged: (value) => _zip = value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 45,
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefixText: _dialCode,
                    enabledBorder: const OutlineInputBorder(),
                    disabledBorder: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    focusedErrorBorder: const OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 17),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Phone Number';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      _phone = (_dialCode + value).removeAllWhitespace,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
             */
            ],
          ),
        ),
      ),
    );
  }
}

// extension Padding on num {
//   SizedBox get ph => SizedBox(height:toDouble() ,);
//   SizedBox get pw => SizedBox(width:toDouble() ,);
// }
