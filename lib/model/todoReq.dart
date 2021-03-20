class TodoReq {
  String title;
  String content;
  int userUid;

  TodoReq({this.title, this.content, this.userUid});

  TodoReq.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    userUid = json['user_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['user_uid'] = this.userUid;
    return data;
  }
}
