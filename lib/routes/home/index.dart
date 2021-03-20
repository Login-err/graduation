import 'package:flutter/material.dart';
import 'package:graduation_project/routes/drawer/index.dart';
import 'package:graduation_project/routes/home/components/home_title.dart';
import 'package:graduation_project/routes/home/components/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(),
      body: Column(
        children: [
          HomeTitle(),
          Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
