import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray500 = fromHex('#979797');

  static Color black900 = fromHex('#000000');

  static Color amber500 = fromHex('#f5be18');

  static Color gray900 = fromHex('#1a1b20');

  static Color orange700 = fromHex('#e77d00');

  static Color deepPurpleA200 = fromHex('#864afc');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray100 = fromHex('#f6f6f6');

  static Color gray5001 = fromHex('#fcfcfc');

  static Color blueGray10063 = fromHex('#63d4cfca');

  static Color gray5002 = fromHex('#f9faff');

  static Color indigoA200 = fromHex('#5f6aff');

  static Color gray50 = fromHex('#f7f8fa');

  static Color whiteA700Ab = fromHex('#abffffff');

  static Color black901 = fromHex('#000000');

  static Color gray600 = fromHex('#7e7a77');

  static Color gray90002 = fromHex('#181818');

  static Color gray700 = fromHex('#626260');

  static Color gray400 = fromHex('#cbbcb1');

  static Color gray60002 = fromHex('#887568');

  static Color gray60001 = fromHex('#6a707c');

  static Color blueGray100 = fromHex('#d4cfcb');

  static Color blueGray10075 = fromHex('#75d4cfca');

  static Color blueGray400 = fromHex('#8390a1');

  static Color indigo50 = fromHex('#e8ecf4');

  static Color gray90001 = fromHex('#1e232c');

  static Color gray200 = fromHex('#f0f0f0');

  static Color gray60003 = fromHex('#808080');

  static Color gray300 = fromHex('#dfdbd9');

  static Color blue50 = fromHex('#eaecff');

  static Color indigo100 = fromHex('#c1c5fe');

  static Color bluegray400 = fromHex('#888888');

  static Color black90019 = fromHex('#19000000');

  static Color blueGray40001 = fromHex('#8a8a8a');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
