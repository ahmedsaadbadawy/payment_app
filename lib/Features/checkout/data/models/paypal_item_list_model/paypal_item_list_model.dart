import 'item.dart';

class PaypalItemListModel {
  List<Item>? items;

  PaypalItemListModel({this.items});

  factory PaypalItemListModel.fromJson(Map<String, dynamic> json) {
    return PaypalItemListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
