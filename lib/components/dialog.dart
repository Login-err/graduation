import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './button.dart';
import '../common/enum.dart';

class MUIDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<String> btn;
  final bool center;
  final Function onClick;

  MUIDialog(
      {Key key,
      this.title,
      @required this.message,
      @required this.btn,
      this.center,
      this.onClick})
      : super(key: key);

  Widget _buildButton(BuildContext context) {
    if (this.btn != null && this.btn.length == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MUIButton(
            text: this.btn[0],
            size: MUIButtonSize.small,
            onClick: () {
              Navigator.pop(context);
              if (this.onClick != null) {
                this.onClick(0);
              }
            },
          ),
          MUIButton(
            text: this.btn[1],
            size: MUIButtonSize.small,
            type: MUIType.primary,
            onClick: () {
              Navigator.pop(context);
              this.onClick(1);
            },
          ),
        ],
      );
    }
    return MUIButton(
      text: this.btn == null ? '我知道了' : this.btn[0],
      type: MUIType.primary,
      onClick: () {
        Navigator.pop(context);
        if (this.onClick != null) {
          this.onClick();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double radio = size.width / 375;

    return Container(
      width: radio * 275,
      padding: EdgeInsets.only(top: radio * 25),
      decoration: new BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: new BorderRadius.all(Radius.elliptical(10, 10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: radio * 30, right: radio * 30),
              child: Text(
                this.title != null ? this.title : '做了么',
                style: TextStyle(
                  fontSize: radio * 18,
                  fontFamily: 'sans-serif',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: EdgeInsets.only(
              top: radio * 16,
              bottom: radio * 30,
              left: radio * 30,
              right: radio * 30,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100,
              ),
              child: SingleChildScrollView(
                child: Text(
                  this.message,
                  style: TextStyle(
                    fontSize: radio * 16,
                    fontFamily: 'sans-serif',
                    height: 1.5,
                  ),
                  textAlign:
                      this.center == true ? TextAlign.center : TextAlign.left,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: radio * 30,
              left: radio * 30,
              right: radio * 30,
            ),
            child: _buildButton(context),
          ),
        ],
      ),
    );
  }
}

class MUIDialogHelper {
  static alert({
    @required BuildContext context,
    @required String message,
    String title,
    List<String> btn,
    bool center,
    Function onClick,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                borderRadius: new BorderRadius.all(
                  Radius.elliptical(10, 10),
                ),
                child: MUIDialog(
                  title: title,
                  message: message,
                  btn: (btn == null || btn.length == 0) ? ['我知道了'] : btn,
                  center: center,
                  onClick: onClick,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static confirm({
    @required BuildContext context,
    @required String message,
    String title,
    List<String> btn,
    bool center,
    Function onClick,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                borderRadius: new BorderRadius.all(Radius.elliptical(10, 10)),
                child: MUIDialog(
                  title: title,
                  message: message,
                  btn: btn == null || btn.length == 0 ? ['取消', '确认'] : btn,
                  center: center,
                  onClick: onClick,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
