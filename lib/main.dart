import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/core/utils/api_keys.dart';

void main() {
  Stripe.publishableKey = ApiKeys.puplishableKey;
  
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}

// Save card data flow :
// paymentIntentModel create payment intent (anount , currancy)
// init paymen sheet (paymenIntentClientSecret)
// presentPaymenSheet()

// Save card data flow :
// paymentIntentModel create payment intent (anount , currancy , customerId)
// keySecret createEphemaralKey(stripeVersion , customerId)
// init paymen sheet (merchantDisplayName , paymenIntentClientSecret , ephemaralKeySecret)
// presentPaymenSheet()