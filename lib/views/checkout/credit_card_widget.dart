import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/services/braintree_service.dart';
import 'package:shopify_store_app/services/configs.dart';
import 'package:shopify_store_app/shopify_models/flutter_simple_shopify.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';
import 'package:shopify_store_app/views/checkout/checkout_confirmation.dart';

class CreditCardWidget extends StatefulWidget {
  Checkout checkout;

  CreditCardWidget(this.checkout, {Key? key}) : super(key: key);

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {

  final checkoutController = Get.find<CheckoutController>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _expiryYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  // final TextEditingController _cardNameHolderController =
  // TextEditingController();

  IconData _suffixIconData = FontAwesomeIcons.creditCard;

  late Checkout checkout;

  String cardNumber = '';
  String expirationMonth = '';
  String expirationYear = '';
  // String cardHolderName = '';
  String cvv = '';

  RegExp regExpForVisa = RegExp(r"^4");
  RegExp regExpForMaster = RegExp(r"^[22-27,51-55]");
  RegExp regExpForAE = RegExp(r"^[34,37]");
  RegExp regExpForDiscover = RegExp(r"^[6011, 622126-622925, 644-649, 65]");
  RegExp regExpForDiners = RegExp(r"^[36, 38, 39]");

  // final CreditCard testCard = CreditCard(
  //   cardNumber: '4111111111111111',
  //   expirationMonth: '12',
  //   expirationYear: '2023',
  //   cvv: '123',
  // );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkout = widget.checkout;
    debugPrint('Checkout ID :${checkout.id}');
  }

  // void _formatCreditCardNumber() {
  //   String text = _cardNumberController.text;
  //   if (text.isNotEmpty) {
  //     // add space after every 4 digits
  //     text = text.replaceAll(RegExp(r'(\d{4})(?=\d)'),
  //         r'$1 '); // replaces every 4 digits with the same 4 digits plus a space after
  //   }
  //   _cardNumberController.value = TextEditingValue(
  //     text: text,
  //     selection: TextSelection.collapsed(offset: text.length),
  //   );
  // }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width - 51,
            height: 60,
            child: TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              maxLength: 19,
              inputFormatters: [CreditCardNumberFormatter1()],
              decoration: InputDecoration(
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(
                  FontAwesomeIcons.creditCard,
                  size: 20,
                ),
                hintText: 'xxxx xxxx xxxx xxxx',
                label: const Text(
                  'Card Number',
                  style: TextStyle(fontSize: 16),
                ),
                helperText: 'Please enter your 16 digit card number.',
                suffixIcon: Icon(_suffixIconData),
              ),
              onChanged: (value) {
                setState(() {
                  if (regExpForVisa.hasMatch(value)) {
                    _suffixIconData = FontAwesomeIcons.ccVisa;
                  } else if (regExpForMaster.hasMatch(value)) {
                    _suffixIconData = FontAwesomeIcons.ccMastercard;
                  } else if (regExpForAE.hasMatch(value)) {
                    _suffixIconData = FontAwesomeIcons.ccAmex;
                  } else if (regExpForDiners.hasMatch(value)) {
                    _suffixIconData = FontAwesomeIcons.ccDinersClub;
                  } else if (regExpForDiscover.hasMatch(value)) {
                    _suffixIconData = FontAwesomeIcons.ccDiscover;
                  }
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 75,
                      height: 60,
                      child: TextField(
                        controller: _expiryMonthController,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          // helperText: 'Expiry Month',
                          label: const Text(
                            'Expiry Month',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 75,
                      height: 60,
                      child: TextField(
                        controller: _expiryYearController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          // helperText: 'Expiry Year',
                          label: const Text(
                            'Expiry Year',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  height: 60,
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      // helperText: 'Enter CVV',
                      label: const Text(
                        'CVV Code',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),

          // Card holder Name TF
          /*const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width - 51,
            height: 60,
            child: TextField(
              controller: _cardNameHolderController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                label: const Text(
                  'Card Holder\'s Name',
                  style: TextStyle(fontSize: 16),
                ),
                helperText: 'Please enter Card holder\'s Name',
              ),
              onChanged: (value) {},
            ),
          ),*/
          const SizedBox(
            height: 15,
          ),
          ElevatedButton.icon(
              icon: const Icon(
                Icons.payment,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: const Size(240, 45),
              ),
              onPressed: () async {
                String cardNumber = _cardNumberController.text.removeAllWhitespace;
                String expiryMonth = _expiryMonthController.text;
                String expiryYear = _expiryYearController.text;
                String cvv = _cvvController.text;
                // String cardHolderName = _cardNameHolderController.text;

                BraintreePaymentMethodNonce? brainTreePayment = await BraintreePaymentService()
                    .requestCreditCardPayment(cardNumber: cardNumber,
                    expirationMonth: expiryMonth,
                    expirationYear: expiryYear,
                    cvv: cvv,
                    amount: checkout.totalPriceV2.amount.toString()
                );
                debugPrint(
                    "Credit Card Payment Data : ${brainTreePayment!.nonce}");

                if (brainTreePayment != null) {
                  String idempotencyKey = CustomConfig()
                      .generateIdempotencyKey();

                  Address mailingAddress = Address(
                    id: checkout.shippingAddress!.id,
                    firstName: checkout.shippingAddress!.firstName,
                    lastName: checkout.shippingAddress!.lastName,
                    address1: checkout.shippingAddress!.address1,
                    city: checkout.shippingAddress!.city,
                    country: checkout.shippingAddress!.country,
                    province: checkout.shippingAddress!.province,
                    provinceCode: checkout.shippingAddress!.provinceCode,
                    phone: checkout.shippingAddress!.phone,
                    zip: checkout.shippingAddress!.zip


                  );

                  await checkoutController.payWithCreditCard(
                      checkoutId: checkout.id,
                      price: checkout.totalPriceV2,
                      billingAddress: mailingAddress,
                      paymentToken: brainTreePayment.nonce,
                      paymentType: brainTreePayment.typeLabel, 
                      idempotencyKey: idempotencyKey
                  ).then((value) => CheckoutConfirmation());
                }
              },
              label: const Text(
                "Pay Now",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
    );
  }
}
