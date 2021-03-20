class Profile {
  String user;
  String token;
  String cache;
  String lastLogin;

  Profile({this.user, this.token, this.cache, this.lastLogin});

  Profile.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    token = json['token'];
    cache = json['cache'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['token'] = this.token;
    data['cache'] = this.cache;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}
