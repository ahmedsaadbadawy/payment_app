import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_app/Features/checkout/data/models/paypal_amount_model/amount_model.dart';
import 'package:payment_app/Features/checkout/data/models/paypal_amount_model/details.dart';
import 'package:payment_app/Features/checkout/data/models/paypal_item_list_model/order_item_model.dart';
import 'package:payment_app/Features/checkout/data/models/paypal_item_list_model/paypal_item_list_model.dart';
import 'package:payment_app/Features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment_app/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:payment_app/core/utils/api_keys.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/payment_intent_input_model.dart';

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
        var cubit = context.read<PaymentCubit>();
        return CustomButton(
            onTap: () {
              if (cubit.selectedPaymentMethodIndex == 0) {
                // ⚠️ we should trigger it once ( at login stage ) ⚠️.
                cubit.createStripeCustomerId(name: 'Mohamed');

                PaymentIntentInputModel paymentIntentInputModel =
                    PaymentIntentInputModel(
                        amount: 95.62,
                        currency: 'USD',
                        customerId: 'cus_QNjl3tqxObowkq');

                cubit.makePayment(
                    paymentIntentInputModel: paymentIntentInputModel);
              } else if (cubit.selectedPaymentMethodIndex == 1) {
                var transctionsData = getTransctionsData();
                executePaypalPayment(context, transctionsData);
              }
            },
            isLoading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }

  ({PaypalAmountModel amount, PaypalItemListModel paypalItemList})
      getTransctionsData() {
    var amount = PaypalAmountModel(
      total: "100",
      currency: 'USD',
      details: Details(
        subtotal: "100",
        shipping: "0",
        shippingDiscount: 0,
      ),
    );

    List<OrderItemModel> orders = [
      OrderItemModel(
        name: 'Apple',
        price: "4",
        quantity: 10,
        currency: 'USD',
      ),
      OrderItemModel(
        name: 'Apple',
        price: "5",
        quantity: 12,
        currency: 'USD',
      ),
    ];

    var paypalItemList = PaypalItemListModel(orders: orders);

    return (amount: amount, paypalItemList: paypalItemList); // Record.
  }

  void executePaypalPayment(
      BuildContext context,
      ({
        PaypalAmountModel amount,
        PaypalItemListModel paypalItemList
      }) transctionsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.paypalClientId,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [
          {
            "amount": transctionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": {
              "items": transctionsData.paypalItemList.orders!
                  .map((order) => order.toJson())
                  .toList(),
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          log('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }
}
