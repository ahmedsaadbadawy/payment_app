import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_app/Features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment_app/Features/checkout/presentation/views/thank_you_view.dart';

import '../../../../../core/utils/api_keys.dart';
import '../../../../../core/widgets/custom_button.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ThankYouView()),
          );
        }

        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
              // ⚠️ we should trigger it once ( at login stage ) ⚠️.
              BlocProvider.of<PaymentCubit>(context)
                  .createStripeCustomerId(name: 'Mohamed');

              PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                      amount: 95.62,
                      currency: 'USD',
                      customerId: ApiKeys.stripeCustomerId);

              BlocProvider.of<PaymentCubit>(context).makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);
            },
            isLoading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }
}
