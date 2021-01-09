import 'package:flutter/material.dart';
import 'package:graduation_project/routes/home/components/InputWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputWidget(),
      ],
    );
  }
}
