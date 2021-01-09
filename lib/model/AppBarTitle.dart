import 'package:flutter/cupertino.dart';

class AppBarTitle with ChangeNotifier {
  String _title = '首页';
  String get title => _title;

  void setTitle(String str) {
    _title = str;
    notifyListeners();
  }
}
