import 'package:dartz/dartz.dart';
import 'package:payment_app/Features/checkout/data/models/payment_intent_input_model.dart';

import '../../../../core/errors/failures.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
