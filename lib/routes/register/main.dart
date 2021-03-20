import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/components/dialog.dart';
import 'package:graduation_project/model/loginRsp.dart';
import 'package:graduation_project/model/registerRsp.dart';
import 'package:graduation_project/model/register_user.dart';
import 'package:graduation_project/util/http.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = false;
  FocusNode _usernameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
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
    return Scaffold(
      appBar: AppBar(title: Text('注册')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  focusNode: _usernameFocus,
                  decoration: InputDecoration(
                    labelText: '用户名',
                    hintText: '用户名',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : '用户名不能为空';
                  }),
              TextFormField(
                controller: _pwdController,
                autofocus: _nameAutoFocus,
                focusNode: _passwordFocus,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '密码',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '密码错误';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _register,
                    textColor: Colors.white,
                    child: Text(
                      '注册',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      _usernameFocus.unfocus();
      _passwordFocus.unfocus();
      try {
        RegisterRsp user =
            await Http().register(_unameController.text, _pwdController.text);
        print(user);
        if (user == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
          return;
        }
        if (user.code == 0) {
          await MUIDialogHelper.alert(
              context: context, message: '注册成功', center: true);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        } else {
          MUIDialogHelper.alert(
              context: context,
              message: user?.msg ?? '网络出现异常，请稍后再试',
              center: true);
        }
      } catch (e) {
        MUIDialogHelper.alert(
            context: context, message: '操作失败，请稍后再试', center: true);
      }
    }
  }
}
