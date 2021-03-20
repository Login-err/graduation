class RegisterReq {
  String username;
  String avatarUrl;
  String password;

  RegisterReq({this.username, this.avatarUrl, this.password});

  RegisterReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatarUrl = json['avatar_url'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar_url'] = this.avatarUrl;
    data['password'] = this.password;
    return data;
  }
}
