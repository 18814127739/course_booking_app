class CourseDetailModel {
  String id;
  String name;
  String images;
  bool like;
  String orgName; // 机构名称
  String orgPhone; // 机构电话
  String orgAddr; // 机构地址
  String orgFoundedTime; // 机构创办时间
  String orgConcept; // 办学理念
  String orgInfo; // 机构介绍
  double price;
  double dailyPrice; // 原价

  CourseDetailModel({
    this.id, this.name, this.images, this.like, this.orgName, this.orgPhone, this.orgAddr, this.price, this.dailyPrice,
  });

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    images = json["images"];
    like = json["like"];
    orgName = json["orgName"];
    orgPhone = json["orgPhone"];
    orgAddr = json["orgAddr"];
    orgFoundedTime = json["orgFoundedTime"];
    orgConcept = json["orgConcept"];
    orgInfo = json["orgInfo"];
    price = json["price"];
    dailyPrice = json["dailyPrice"];
  }
}