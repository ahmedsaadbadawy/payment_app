class PaymentIntentInputModel {
  final num amount;
  final String currency;
  final String customerId;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  toJson() {
    return {
      'amount': (amount.toInt() * 100).toString(),
      'currency': currency,
      'customer': customerId,
    }; // cause we will use it as Body (map) in Post Request.
  }
}
