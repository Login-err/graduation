class GetTodoRsp {
  int code;
  String msg;
  Data data;
  GetTodoRsp({this.code, this.msg, this.data});

  GetTodoRsp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['code'] = this.code;
    val['msg'] = this.msg;
    return val;
  }
}

class Data {
  List<TodoInfo> list;

  Data({this.list});
  Data.fromJson(Map<String, dynamic> json) {
    list = new List();
    json['list'].forEach((item) {
      list.add(TodoInfo.fromJson(item));
    });
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list'] = this.list;
    return data;
  }
}

class TodoInfo {
  String title;
  String content;
  int userUid;
  String time;
  int uid;
  int isEnd;

  TodoInfo(
      {this.title,
      this.uid,
      this.content,
      this.userUid,
      this.time,
      this.isEnd});

  TodoInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    userUid = json['user_uid'];
    uid = json['uid'];
    time = json['time'];
    isEnd = json['isEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['user_uid'] = this.userUid;
    data['uid'] = this.uid;
    data['time'] = this.time;
    data['isEnd'] = this.isEnd;
    return data;
  }
}
