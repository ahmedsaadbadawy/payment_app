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
              // BlocProvider.of<PaymentCubit>(context)
              //     .createStripeCustomerId(name: 'Mohamed');

              // PaymentIntentInputModel paymentIntentInputModel =
              //     PaymentIntentInputModel(
              //         amount: 95.62,
              //         currency: 'USD',
              //         customerId: 'cus_QNjl3tqxObowkq');

              // BlocProvider.of<PaymentCubit>(context).makePayment(
              //     paymentIntentInputModel: paymentIntentInputModel);
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId: "YOUR CLIENT ID",
                  secretKey: "YOUR SECRET KEY",
                  transactions: [
                    {
                      "amount": amount.toJson(),
                      "description": "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": paypalItemList.toJson(),

                        // Optional
                        //   "shipping_address": {
                        //     "recipient_name": "Tharwat samy",
                        //     "line1": "tharwat",
                        //     "line2": "",
                        //     "city": "tharwat",
                        //     "country_code": "EG",
                        //     "postal_code": "25025",
                        //     "phone": "+00000000",
                        //     "state": "ALex"
                        //  },
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
            },
            isLoading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }
}
