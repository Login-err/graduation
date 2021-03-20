import 'package:graduation_project/model/getTodoRsp.dart';
import 'package:graduation_project/routes/detail/index.dart';

class GetTodoDetailReq {
  int todoId;

  GetTodoDetailReq({this.todoId});

  GetTodoDetailReq.fromJson(Map<String, dynamic> json) {
    todoId = json['todoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todoId'] = this.todoId;
    return data;
  }
}

class GetTodoDetailRsp {
  int code;
  String msg;
  Data data;
  GetTodoDetailRsp({this.code, this.msg, this.data});

  GetTodoDetailRsp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = new Map<String, dynamic>();
    val['code'] = this.code;
    val['msg'] = this.msg;
    return val;
  }
}

class Data {
  TodoInfo detail;

  Data({this.detail});
  Data.fromJson(Map<String, dynamic> json) {
    detail = TodoInfo.fromJson(json['detail']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
  }
}
