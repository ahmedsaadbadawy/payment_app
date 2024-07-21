import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/Features/checkout/presentation/views/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';

import '../../manager/cubit/payment_cubit.dart';


class PaymentMethodsListView extends StatelessWidget {
  const PaymentMethodsListView({super.key});
  
  final List<String> paymentMethodsItems = const [
    'assets/images/card.svg',
    'assets/images/paypal.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        var cubit = context.read<PaymentCubit>();
        return SizedBox(
          height: 62,
          child: ListView.builder(
            itemCount: paymentMethodsItems.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    cubit.selectPaymentMethod(index);
                  },
                  child: PaymentMethodItem(
                    isActive: cubit.selectedPaymentMethodIndex == index,
                    image: paymentMethodsItems[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

