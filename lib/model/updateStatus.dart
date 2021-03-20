import 'package:graduation_project/model/getTodoRsp.dart';
import 'package:graduation_project/routes/detail/index.dart';

class UpdateStatusReq {
  int isEnd;
  int todoId;

  UpdateStatusReq({this.isEnd, this.todoId});

  UpdateStatusReq.fromJson(Map<String, dynamic> json) {
    todoId = json['todoId'];
    isEnd = json['isEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todoId'] = this.todoId;
    data['isEnd'] = this.isEnd;
    return data;
  }
}
