class TicketModel{
  String? id;
  String? title;
  String? description;

  TicketModel({this.id, this.title, this.description});

factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    id:json['_id'],
    title: json['title'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
  };


}