class ShippingAddress {
  final String street;
  final String city;
  final String phone;

  ShippingAddress({
    required this.street,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'phone': phone,
    };
  }
}