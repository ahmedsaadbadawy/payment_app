class PaymentIntentInputModel {
  final String amount;
  final String currency;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
  });

  toJson() {
    return {
      'amount': amount,
      'currency': currency,
    }; // cause we will use it as Body (map) in Post Request. 
  }
}
