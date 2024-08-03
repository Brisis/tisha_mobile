import 'package:intl/intl.dart';

String formatPrice(double price) {
  var formatter = NumberFormat.currency(
      locale: "en_US", decimalDigits: 2, customPattern: "###.0#");
  return "\$${formatter.format(price)}";
}
