import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_app/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_app/Features/checkout/data/repos/checkout_repo.dart';

import '../../../../../core/utils/api_keys.dart';
import '../../../data/repos/customer_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo, this.customerRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;
  final CustomerRepo customerRepo;

  int selectedPaymentMethodIndex = 0;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());

    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

    data.fold(
      (l) => emit(PaymentFailure(l.errMessage)),
      (r) => emit(
        PaymentSuccess(),
      ),
    );
  }

  
  Future createStripeCustomerId({required String name}) async {
    var data = await customerRepo.createStripeCustomerId(name: name);

    data.fold((l) => emit(CreateCustomerIdFailure(l.errMessage)),
        (stripeCustomerDataModel) {
      ApiKeys.stripeCustomerId = stripeCustomerDataModel.id!;
      log(ApiKeys.stripeCustomerId);
      emit(CreateCustomerIdSuccess());
    });
  }

  void selectPaymentMethod(int index) {
    selectedPaymentMethodIndex = index;
    emit(PaymentMethodSelected(index)); // Add this line
  }

   @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
