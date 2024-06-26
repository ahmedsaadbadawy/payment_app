class PaymentIntentInputModel {
  final num amount;
  final String currency;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
  });

  toJson() {
    return {
      'amount': (amount.toInt() * 100).toString(),
      'currency': currency,
    }; // cause we will use it as Body (map) in Post Request.
  }
}
