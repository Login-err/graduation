import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';

abstract class MusicCookieOperator {
  void set({String name, String value, String url, int hour});

  String get({String name, String url});

  void del({String name, String url});
}

const String defaultUrl = '127.0.0.1:3000';

// 客户端换票时机在于三处：
// 1. 启动app，2. 后台进入前台，3. 逗留超过 6 小时，
// 而票据的有效期是24小时，而 Flutter 这侧是打开 FlutterVC 就会更新票据
// 因此，Flutter cookie 的最差有效期是 18 小时。
const int defaultExpires = 18;

class MusicCookie implements MusicCookieOperator {
  static final MusicCookie _instance = MusicCookie._internal();

  factory MusicCookie() => _instance;

  static MusicCookie get instance => MusicCookie._internal();

  CookieJar cookieJar;

  MusicCookie._internal() {
    if (cookieJar == null) {
      cookieJar = CookieJar();
    }
  }

  void set(
      {String name,
      String value,
      String url = defaultUrl,
      int hour = defaultExpires}) {
    List<Cookie> cookies = <Cookie>[
      Cookie(name, value)
        ..expires = new DateTime.now().add(Duration(hours: hour)),
    ];
    cookieJar.saveFromResponse(Uri.parse(url), cookies);
  }

  String get({String name, String url = defaultUrl}) {
    var cookies = cookieJar.loadForRequest(Uri.parse(url));
    String ret = '';
    cookies.forEach((cookie) {
      if (cookie.name == name) {
        ret = cookie.value;
      }
    });
    return ret;
  }

  void del({String name, String url = defaultUrl}) {
    var cookies = cookieJar.loadForRequest(Uri.parse(url));

    cookies.forEach((cookie) {
      if (cookie.name == name) {
        cookie.expires = DateTime(1997);
      }
    });
  }
}
