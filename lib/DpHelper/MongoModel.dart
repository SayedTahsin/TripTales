class MongoDbModel {
  String? name;
  String? date;
  String? caption;
  int? likes;

  MongoDbModel({this.name, this.date, this.caption, this.likes});

  MongoDbModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    date = json['date'];
    caption = json['caption'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['date'] = this.date;
    data['caption'] = this.caption;
    data['likes'] = this.likes;
    return data;
  }
}
