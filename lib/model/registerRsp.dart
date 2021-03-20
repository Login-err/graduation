class RegisterRsp {
  int code;
  String msg;
  RegisterRsp({this.code, this.msg});

  RegisterRsp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['code'] = this.code;
    val['msg'] = this.msg;
    return val;
  }
}

class Data {
  // String token;

  // Data({this.token});
  // Data.fromJson(Map<String, dynamic> json) {
  //   token = json['token'];
  // }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['token'] = this.token;
  //   return data;
  // }
}
