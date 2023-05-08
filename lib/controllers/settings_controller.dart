
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController{

  var selectedCurrency = ''.obs;
  var selectedCurrencyIcon = CupertinoIcons.money_dollar.obs;
  var selectedLanguage = ''.obs;
  // var selectedLanguageIcon = FlagsCode.US.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedLanguage.value = 'English';
    selectedCurrency.value = 'USD';
    selectedCurrencyIcon.value = CupertinoIcons.money_dollar;
    // selectedLanguageIcon.value = FlagsCode.US;
  }

}