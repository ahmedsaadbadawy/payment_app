import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/stripe_customer_data_model/stripe_customer_data_model.dart';

abstract class CustomerRepo {
  Future<Either<Failure, StripeCustomerDataModel>> createStripeCustomerId(
      {required String name});
}