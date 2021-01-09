import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  InputWidget({Key key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _inputController,
            textInputAction: TextInputAction.search,
          ),
        ),
        InkWell(
          child: Icon(Icons.search),
          onTap: () {},
        )
      ],
    );
  }
}
