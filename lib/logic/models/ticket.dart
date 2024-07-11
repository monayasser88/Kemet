class Ticket {
  String name;
  double price;
  int quantity;

  Ticket({required this.name, required this.price, this.quantity = 1});

  Ticket copyWith({String? name, double? price, int? quantity}) {
    return Ticket(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}