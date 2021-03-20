class GetTodoReq {
  int userUid;
  int isEnd;

  GetTodoReq({this.userUid, this.isEnd});

  GetTodoReq.fromJson(Map<String, dynamic> json) {
    userUid = json['user_uid'];
    isEnd = json['isEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_uid'] = this.userUid;
    data['isEnd'] = this.isEnd;
    return data;
  }
}
