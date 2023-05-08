

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class CustomConfig{

  // LimeLight Copy Store
  static const String shopifyStoreFrontAPIAccessToken = '342a0b120c1c13ae1997848236a909bd';
  // static const String shopifyAdminAPIAccessToken = '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';
  static const String shopifyAppName = 'LimeLightCopy';
  static const String shopifyStoreLink = 'limelightcopy.myshopify.com';
  static const String shopifyApiVersion = '2023-04';

  static const String braintreeTokenizationKey = 'sandbox_bnzfmj53_6j3m7wnchbd3q7vn';
  static const String braintreeClientToken = '28d9762b7b0ce827fd39918d97576aa7';

  // Mimi Khan Store
  /*static const String shopifyStoreFrontAPIAccessToken = '9b47ac0a84906cd4c49c541285d9b7eb';
  // static const String shopifyAdminAPIAccessToken = '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';
  static const String shopifyAppName = 'MimiKhanStore';
  static const String shopifyStoreLink = 'mimi-khan-store.myshopify.com';
  static const String shopifyApiVersion = '2023-01';*/


  String generateIdempotencyKey() {
    var uuid = const Uuid();
    return uuid.v4();
  }

}

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove any non-digits
    newText = newText.replaceAll(RegExp(r'[^\d]'), '');

    // Add a space after every 4 digits
    newText = newText.replaceAllMapped(
        RegExp(r'.{4}'), (match) => '${match.group(0)} ');

    // If the text is longer than 19 characters (16 digits + 3 spaces),
    // truncate the excess characters
    if (newText.length > 19) {
      newText = newText.substring(0, 19);
    }

    // Create a new TextEditingValue with the formatted text and the selection
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}
class CreditCardNumberFormatter1 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove any non-digits
    newText = newText.replaceAll(RegExp(r'[^\d]'), '');

    // Add a space after every 4 digits
    newText = newText.replaceAllMapped(
        RegExp(r'.{1,4}'), (match) => '${match.group(0)} ').trim();

    // Determine the new cursor position
    int cursorPosition = newValue.selection.baseOffset;
    int oldLength = oldValue.text.length;
    int newLength = newText.length;
    int diff = newLength - oldLength;
    if (diff > 0 && cursorPosition == oldLength) {
      // If new characters were added and the cursor was at the end of the old text,
      // move the cursor to the end of the new text
      cursorPosition = newLength;
    } else if (diff < 0 && cursorPosition == newLength + 1) {
      // If characters were deleted and the cursor was at the end of the old text,
      // move the cursor to the end of the new text
      cursorPosition = newLength;
    } else if (cursorPosition % 5 == 0 && diff > 0) {
      // If new characters were added and the cursor is at a position where a space will be added,
      // move the cursor one position to the right
      cursorPosition += 1;
    } else if (cursorPosition % 5 == 0 && diff < 0) {
      // If characters were deleted and the cursor is at a position where a space was removed,
      // move the cursor one position to the left
      cursorPosition -= 1;
    }

    // Create a new TextEditingValue with the formatted text and the selection
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}



