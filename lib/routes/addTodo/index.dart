import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/common/adaptive.dart';
import 'package:graduation_project/components/dialog.dart';
import 'package:graduation_project/model/loginRsp.dart';
import 'package:graduation_project/model/todoRsp.dart';
import 'package:graduation_project/util/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = false;
  FocusNode _usernameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  String nick = '';
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    getUsername().then((value) {
      setState(() {
        nick = value;
      });
    });
  }

  void sendOut() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      final prefs = await SharedPreferences.getInstance();
      int uid = prefs.getInt('uid');
      _usernameFocus.unfocus();
      _passwordFocus.unfocus();
      try {
        TodoRsp todo = await Http()
            .addTodo(_titleController.text, _contentController.text, uid);
        if (todo == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
          return;
        }
        if (todo.code == 0) {
          await MUIDialogHelper.alert(
              context: context, message: '发布成功', center: true);
          await Future.delayed(Duration(seconds: 1));
          Navigator.of(context).pop();
        } else {
          MUIDialogHelper.alert(
              context: context,
              message: todo?.msg ?? '发布失败，请稍后再试',
              center: true);
        }
      } catch (e) {
        MUIDialogHelper.alert(
            context: context, message: '发布失败，请稍后再试', center: true);
      }
    }
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Text('取消'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  '添加待办',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  nick,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w200,
                  ),
                )
              ],
            ),
            alignment: Alignment.center,
          ),
          actions: [
            GestureDetector(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: SizeFit().setWidth(20)),
                  child: Text(
                    '发布',
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              onTap: () => sendOut(),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: _nameAutoFocus,
                      controller: _titleController,
                      focusNode: _usernameFocus,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: '标题',
                        hintText: '标题',
                        prefixIcon: Icon(Icons.title),
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : '标题不能为空~';
                      },
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                          ),
                          child: TextFormField(
                            controller: _contentController,
                            autofocus: _nameAutoFocus,
                            focusNode: _passwordFocus,
                            decoration: InputDecoration(
                              labelText: '详情',
                              hintText: '添加待办事...',
                            ),
                            maxLines: 2,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 10,
                          child: Icon(Icons.details),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
