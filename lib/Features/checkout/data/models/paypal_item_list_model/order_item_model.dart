class OrderItemModel {
  final String? name;
  final int? quantity;
  final String? price;
  final String? currency;

  OrderItemModel({required this.name,required this.price,required this.quantity,required this.currency});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        name: json['name'] as String?,
        quantity: json['quantity'] as int?,
        price: json['price'] as String?,
        currency: json['currency'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'currency': currency,
      };
}
