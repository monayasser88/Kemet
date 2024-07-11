class Trip {
  //String tId;
  String title;
  String description;
  // int priceAfterDiscount;

  Trip({
    // required this.tId,
    required this.title,
    required this.description,
    //required this.priceAfterDiscount,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      // tId: json['_id'],
      title: json['title'],
      description: json['description'],
      // priceAfterDiscount: json['priceAfterDiscount'],
    );
  }
}

class MyTicketItem {
  Trip trip;
  int quantity;
  String myTId;
  int price;

  MyTicketItem({
    required this.trip,
    required this.quantity,
    required this.myTId,
    required this.price
  });

  factory MyTicketItem.fromJson(Map<String, dynamic> json) {
    return MyTicketItem(
      trip: Trip.fromJson(json['trip']),
      quantity: json['quantity'],
      myTId: json['_id'],
      price: json['price'],
    );
  }
}

class MyTicket {
  String id;
  String user;
  List<MyTicketItem> myTicketItems;
  int totalPrice;

  MyTicket({
    required this.id,
    required this.user,
    required this.myTicketItems,
    required this.totalPrice,
  });

  factory MyTicket.fromJson(Map<String, dynamic> json) {
    List<dynamic> ticketItemsJson = json['myTicketItems'];
    List<MyTicketItem> ticketItems =
        ticketItemsJson.map((item) => MyTicketItem.fromJson(item)).toList();

    return MyTicket(
      id: json['_id'],
      user: json['user'],
      myTicketItems: ticketItems,
      totalPrice: json['totalPrice'],
    );
  }
}
