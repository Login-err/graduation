class TodoRsp {
  int code;
  String msg;

  TodoRsp({this.code, this.msg});

  TodoRsp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  int uid;
  String title;
  String content;
  String time;
  String userUid;

  Data({this.uid, this.title, this.content, this.time, this.userUid});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    title = json['title'];
    content = json['content'];
    time = json['time'];
    userUid = json['user_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['content'] = this.content;
    data['time'] = this.time;
    data['user_uid'] = this.userUid;
    return data;
  }
}
