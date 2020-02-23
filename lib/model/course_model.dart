class CourseModel {
  String id;
  String name;
  String image;
  String desc;
  double price;
  int bookNum;

  CourseModel({
    this.id, this.name, this.image, this.desc, this.price, this.bookNum
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    desc = json["desc"];
    price = json["price"];
    bookNum = json["bookNum"];
  }
}