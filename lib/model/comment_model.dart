class CommentModel {
  String id;
  String userName;
  String content;
  String avatar;
  int score;
  String date;
  String images;

  CommentModel(
    this.id, this.userName, this.content, this.avatar, this.score, this.date, this.images
  );

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userName = json["userName"];
    content = json["content"];
    avatar = json["avatar"];
    score = json["score"];
    date = json["date"];
    images = json["images"];
  }
}