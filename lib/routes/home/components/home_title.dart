import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graduation_project/util/tool.dart';

class HomeTitle extends StatefulWidget {
  HomeTitle({Key key}) : super(key: key);
  @override
  _HomeTitleState createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> {
  DateTime now = DateTime.now();
  Timer timer;
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime newNow = DateTime(
          now.year, now.month, now.day, now.hour, now.minute, now.second - 1);
      if (newNow.minute != now.minute) {
        setState(() {
          now = newNow;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 90,
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    formatTime(now.day),
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formatTime(now.month),
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      now.year.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey[100],
            child: Center(
              child: Text(
                '${formatTime(now.hour)}:${formatTime(now.minute)}',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
