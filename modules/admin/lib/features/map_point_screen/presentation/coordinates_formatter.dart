import 'package:flutter/services.dart';

class CoordinatesInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (text.length > 2 && text[2] != '.') {
      text = '${text.substring(0, 2)}.${text.substring(2)}';
    }
    if (text.length > 9 && text[8] != ',') {
      text = '${text.substring(0, 8)}, ${text.substring(8)}';
    }
    if (text.length > 12 && text[12] != '.') {
      text = '${text.substring(0, 12)}.${text.substring(12)}';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}