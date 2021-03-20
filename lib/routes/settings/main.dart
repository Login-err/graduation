import 'package:flutter/cupertino.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back)),
        middle: Text('设置'),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        border: Border(
          bottom: BorderSide(color: Color(0x00ffffff), width: 1.0),
        ),
      ),
      child: Container(
        child: Column(children: [
          Row(
            children: [
              Text('用户名'),
              Text('admin'),
            ],
          ),
          CupertinoButton(
            child: Text('退出登录'),
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
