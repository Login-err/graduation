class Userinfo {
  int uid;
  String username;
  String avatarUrl;
  String password;

  Userinfo({this.uid, this.username, this.avatarUrl, this.password});

  Userinfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['avatar_url'] = this.avatarUrl;
    data['password'] = this.password;
    return data;
  }
}
