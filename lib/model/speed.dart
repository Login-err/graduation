class SpeedReq {
  String cgiName;
  int time;
  SpeedReq({this.cgiName, this.time});

  SpeedReq.fromJson(Map<String, dynamic> json) {
    cgiName = json['cgiName'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['cgiName'] = this.cgiName;
    val['time'] = this.time;
    return val;
  }
}
