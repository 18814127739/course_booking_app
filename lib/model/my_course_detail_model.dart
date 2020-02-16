class MyCourseDetailModel {
  String id;
  String name;
  String image;
  String teacher;
  int total;
  int finish;
  int rest;
  String beginDate;
  String endDate;
  List<List<String>> coursePlan;

  MyCourseDetailModel({
    this.id,
    this.name,
    this.image,
    this.teacher,
    this.total,
    this.finish,
    this.rest,
    this.beginDate,
    this.endDate,
    this.coursePlan,
  });

  MyCourseDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    teacher = json["teacher"];
    total = json["total"];
    finish = json["finish"];
    rest = json["rest"];
    beginDate = json["beginDate"];
    endDate = json["endDate"];
    coursePlan = json["coursePlan"];
  }
}