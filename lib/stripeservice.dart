import 'package:http/http.dart' as http;

class StripeServices {
  String secretKey =
      "pk_test_51N3ozXKuYtdF845ofkT3mnJPklviwqoYWXmh4rBRta7f4ULTStn7H5FPUizInnktKg2yDp2YdeiU9liipwYjv8hj00OyAY8oAp";
  String publishKey =
      "sk_test_51N3ozXKuYtdF845oo54vweQDKUNllgiNE5EZwtO2UVMxVGQhJoysGNOZEYRrHbMtj6SNI72W58B4c50Im7IxXGKs00DASLWthd";
  static Future<dynamic> createCheckout(
      List<dynamic> product_items, totalAmount) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
    String lineItems = "";
    int index = 0;
  }
}
