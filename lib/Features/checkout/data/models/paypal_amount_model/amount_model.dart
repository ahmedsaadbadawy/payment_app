import 'details.dart';

class PaypalAmountModel {
  final String? total;
  final String? currency;
  final Details? details;

  PaypalAmountModel({required this.total,required this.currency,required this.details});

  factory PaypalAmountModel.fromJson(Map<String, dynamic> json) =>
      PaypalAmountModel(
        total: json['total'] as String?,
        currency: json['currency'] as String?,
        details: json['details'] == null
            ? null
            : Details.fromJson(json['details'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'currency': currency,
        'details': details?.toJson(),
      };
}
