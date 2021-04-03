import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/components/dialog.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/model/loginRsp.dart';
import 'package:graduation_project/model/user.dart';
import 'package:graduation_project/util/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '登录',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
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
                    // 校验用户名（不能为空）
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
                      // color: Theme.of(context).primaryColor,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      textColor: Colors.black,
                      child: Text(
                        '立即注册',
                        style: TextStyle(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _onLogin,
                      textColor: Colors.white,
                      child: Text(
                        '立即登录',
                        style: TextStyle(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      _usernameFocus.unfocus();
      _passwordFocus.unfocus();
      try {
        LoginRsp user = await Http()
            .login(_unameController.text.trim(), _pwdController.text.trim());
        if (user != null && user.code == 0) {
          final prefs = await SharedPreferences.getInstance();
          prefs.clear();
          prefs.setString('token', user?.data?.token ?? '');
          prefs.setString('username', _unameController.text ?? '');
          prefs.setInt('uid', user?.data?.uid ?? '');
          await MUIDialogHelper.alert(
              context: context, message: '登录成功', center: true);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EntryPage()));
          });
        } else {
          MUIDialogHelper.alert(
              context: context,
              message: user?.msg ?? '登录失败，请稍后再试',
              center: true);
        }
      } catch (e) {
        MUIDialogHelper.alert(
            context: context, message: '登录失败，请稍后再试', center: true);
      }
    }
  }
}
