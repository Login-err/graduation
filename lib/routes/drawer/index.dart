import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserHeader(), // 可在这里替换自定义的header
          ListTile(
            title: Text('已完成'),
            leading: new CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: new Icon(Icons.history),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/joinHistory');
            },
          ),
          ListTile(
            title: Text('退出登录'),
            leading: new CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: new Icon(Icons.exit_to_app),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  Future _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserName(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // ignore: missing_required_param
          return UserAccountsDrawerHeader(
            accountName: Text(snapshot.data),
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundImage:
                    new ExactAssetImage("assets/images/avatar.png"),
              ),
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          );
        }
        return Container();
      },
    );
  }
}
