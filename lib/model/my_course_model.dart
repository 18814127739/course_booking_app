class MyCourseModel {
  String id;
  String name;
  String image;
  String teacher;
  int total;
  int finish;

  MyCourseModel(
    this.id,
    this.name,
    this.image,
    this.teacher,
    this.total,
    this.finish,
  );

  MyCourseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    teacher = json["teacher"];
    total = json["total"];
    finish = json["finish"];
  }
}