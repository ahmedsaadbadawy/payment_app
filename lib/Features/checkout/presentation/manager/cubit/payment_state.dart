part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String errMessage;
  PaymentFailure(this.errMessage);
}

final class CreateCustomerIdSuccess extends PaymentState {}

final class CreateCustomerIdFailure extends PaymentState {
  final String errMessage;
  CreateCustomerIdFailure(this.errMessage);
}

final class PaymentMethodSelected extends PaymentState { 
  final int selectedIndex;
  PaymentMethodSelected(this.selectedIndex);
}