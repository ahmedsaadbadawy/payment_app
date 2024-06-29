import 'package:dartz/dartz.dart';

import 'package:payment_app/core/errors/failures.dart';

import '../../../../core/utils/stripe_service.dart';
import '../models/stripe_customer_data_model/stripe_customer_data_model.dart';
import 'customer_repo.dart';

class CustomerRepoImpl extends CustomerRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, StripeCustomerDataModel>> createStripeCustomerId(
      {required String name}) async {
    try {
      StripeCustomerDataModel stripeCustomerDataModel =
          await stripeService.createStripeCustomerId(name: name);

      return right(stripeCustomerDataModel);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
