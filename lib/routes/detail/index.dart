import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:graduation_project/components/dialog.dart';
import 'package:graduation_project/model/getTodoRsp.dart';
import 'package:graduation_project/util/http.dart';

class TodoDetail extends StatefulWidget {
  final int todoId;
  TodoDetail({Key key, this.todoId}) : super(key: key);

  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  TodoInfo info;
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    if ((widget?.todoId ?? null) != null) {}
    Http().getTodoDetail(widget.todoId).then((value) {
      if (value == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
        return;
      }
      if ((value?.data?.detail ?? null) != null) {
        setState(() {
          info = value.data.detail;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      // 设计尺寸
      designSize: Size(750, 1624),
      allowFontScaling: false,
    );
    return info == null
        ? Container()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '详细信息',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '标题:  ${info.title}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '内容:  ${info.content}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '当前状态:  ${info.isEnd == 0 ? "尚未完成" : "已完成"}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '时间:  ${info.time}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  info.isEnd == 0
                      ? Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Http()
                                    .updateTodoStatus(1, info.uid)
                                    .then((res) {
                                  if (res.code == 0) {
                                    setState(() {
                                      info.isEnd = 1;
                                    });
                                  }
                                  MUIDialogHelper.alert(
                                      context: context,
                                      message: res.msg,
                                      center: true);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Text('Done'),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
  }
}
