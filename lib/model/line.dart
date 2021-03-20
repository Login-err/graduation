class LineReq {
  // ignore: non_constant_identifier_names
  int user_uid;

  // ignore: non_constant_identifier_names
  LineReq({this.user_uid});

  LineReq.fromJson(Map<String, dynamic> json) {
    user_uid = json['user_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_uid'] = this.user_uid;
    return data;
  }
}

class LineRsp {
  int code;
  String msg;
  DataList data;
  LineRsp({this.code, this.msg, this.data});

  LineRsp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = DataList.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['code'] = this.code;
    val['msg'] = this.msg;
    val['data'] = this.data;
    return val;
  }
}

class DataList {
  List list;

  DataList({this.list});
  DataList.fromJson(Map<String, dynamic> json) {
    list = new List();
    json['list'].forEach((item) {
      list.add(DayInfo.fromJson(item));
    });
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list'] = this.list;
    return data;
  }
}

class DayInfo {
  String timer;
  int count;
  DayInfo({this.timer, this.count});

  DayInfo.fromJson(Map<String, dynamic> json) {
    timer = json['timer'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['timer'] = this.timer;
    val['count'] = this.count;
    return val;
  }
}
