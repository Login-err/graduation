import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:graduation_project/common/global.dart';
import 'package:graduation_project/model/getDetail.dart';
import 'package:graduation_project/model/getTodoReq.dart';
import 'package:graduation_project/model/getTodoRsp.dart';
import 'package:graduation_project/model/line.dart';
import 'package:graduation_project/model/loginReq.dart';
import 'package:graduation_project/model/loginRsp.dart';
import 'package:graduation_project/model/registerReq.dart';
import 'package:graduation_project/model/registerRsp.dart';
import 'package:graduation_project/model/speed.dart';
import 'package:graduation_project/model/todoReq.dart';
import 'package:graduation_project/model/todoRsp.dart';
import 'package:graduation_project/model/updateStatus.dart';
import 'package:graduation_project/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HttpOperator {
  Future<Response<String>> get(String url, Map<String, dynamic> params,
      {bool useProxy: false});

  Future<Response<String>> post(String url, Map params, {bool useProxy: false});
}

// String url = 'http://192.168.1.102:7001';
String url = 'http://1.13.5.130:7001';

getToken() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  return token;
}

String token = "";

/// 网络模块
class Http {
  Dio dio = Dio(BaseOptions(baseUrl: url, headers: {
    HttpHeaders.authorizationHeader: token,
  }));

  Future<RegisterRsp> register(String username, String pwd) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    LoginReq data = LoginReq(password: pwd, username: username);
    final r = await dio.post(
      '/register/',
      data: data,
    );

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'register');
    return RegisterRsp.fromJson(r.data);
  }

  Future<LoginRsp> login(String username, String pwd) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    LoginReq data = LoginReq(password: pwd, username: username);
    final r = await dio.post(
      '/login/',
      data: data,
    );
    token = await getToken();
    dio = Dio(BaseOptions(baseUrl: url, headers: {
      HttpHeaders.authorizationHeader: token,
    }));

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'login');
    return LoginRsp.fromJson(r.data);
  }

  Future<TodoRsp> addTodo(String title, String content, int userUid) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    TodoReq data = TodoReq(
      title: title,
      content: content,
      userUid: userUid,
    );
    token = await getToken();
    dio.options.headers = {HttpHeaders.authorizationHeader: token};
    final r = await dio.post(
      '$url/addTodolist/',
      data: data,
    );

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'addTodolist');
    return TodoRsp.fromJson(r.data);
  }

  Future<GetTodoRsp> getTodo(int userUid, int isEnd) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    GetTodoReq data = GetTodoReq(
      userUid: userUid,
      isEnd: isEnd,
    );
    token = await getToken();
    dio.options.headers = {HttpHeaders.authorizationHeader: token};
    final r = await dio.post(
      '$url/getList/',
      data: data,
    );

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'getList');
    return GetTodoRsp.fromJson(r.data);
  }

  Future<GetTodoDetailRsp> getTodoDetail(int todoId) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    GetTodoDetailReq data = GetTodoDetailReq(
      todoId: todoId,
    );
    token = await getToken();
    dio.options.headers = {HttpHeaders.authorizationHeader: token};
    final r = await dio.post(
      '$url/getListDetail/',
      data: data,
    );

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'getListDetail');
    return GetTodoDetailRsp.fromJson(r.data);
  }

  Future<RegisterRsp> updateTodoStatus(int isEnd, int todoId) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    UpdateStatusReq data = UpdateStatusReq(
      isEnd: isEnd,
      todoId: todoId,
    );
    token = await getToken();
    dio.options.headers = {HttpHeaders.authorizationHeader: token};
    final r = await dio.post(
      '$url/updateStatus/',
      data: data,
    );

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'updateStatus');
    return RegisterRsp.fromJson(r.data);
  }

  // ignore: non_constant_identifier_names
  Future<LineRsp> getListByDay(int user_uid) async {
    int beginTime = DateTime.now().millisecondsSinceEpoch;
    LineReq data = LineReq(
      user_uid: user_uid,
    );
    token = await getToken();
    dio.options.headers = {HttpHeaders.authorizationHeader: token};
    final r = await dio.post(
      '$url/getListByDay/',
      data: data,
    );

    int endTime = DateTime.now().millisecondsSinceEpoch;
    speedReport(endTime - beginTime, 'getListByDay');
    return LineRsp.fromJson(r.data);
  }

  Future<RegisterRsp> speedReport(int time, String cgiName) async {
    SpeedReq data = SpeedReq(
      time: time,
      cgiName: cgiName,
    );
    token = await getToken();
    dio.options.headers = {HttpHeaders.authorizationHeader: token};
    final r = await dio.post(
      '$url/speedRep/',
      data: data,
    );
    return RegisterRsp.fromJson(r.data);
  }
}
