import 'order_item_model.dart';

class PaypalItemListModel {
  final List<OrderItemModel>? orders;

  PaypalItemListModel({required this.orders});

  factory PaypalItemListModel.fromJson(Map<String, dynamic> json) {
    return PaypalItemListModel(
      orders: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': orders?.map((e) => e.toJson()).toList(),
      };
}
