class LoginRsp {
  int code;
  String msg;
  Data data;
  LoginRsp({this.code, this.msg, this.data});

  LoginRsp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['code'] = this.code;
    val['msg'] = this.msg;
    val['data'] = this.data;
    return val;
  }
}

class Data {
  String token;
  int uid;
  String username;
  String avatar;

  Data({this.token, this.uid, this.username, this.avatar});
  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    uid = json['uid'];
    username = json['username'];
    avatar = json['avatar'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}
