import 'package:flutter/material.dart';
import 'package:graduation_project/common/adaptive.dart';

class EditArticelState extends StatefulWidget {
  EditArticelState({Key key}) : super(key: key);

  @override
  _EditArticelStateState createState() => _EditArticelStateState();
}

class _EditArticelStateState extends State<EditArticelState> {
  @override
  Widget build(BuildContext context) {
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
            child: Text('发布讨论'),
            alignment: Alignment.center,
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: SizeFit().setWidth(20)),
                  child: Text(
                    '发布',
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ],
        ),
        body: Container(
          child: Text(
            '123',
          ),
        ),
      ),
    );
  }
}
