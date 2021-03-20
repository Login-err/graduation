import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../common/enum.dart';

/// 通过设置 Button 的属性来产生不同的按钮样式
/// 推荐顺序为：type -> color -> shape -> size -> disabled。
class MUIButton extends StatefulWidget {
  final String text;
  final Function onClick;
  final Color color;
  final MUIType type;
  final MUIShape shape;
  final MUIButtonSize size;
  final bool disabled;
  final Color backgroundColor;
  final double fontSize;
  final TextStyle style;
  // todo icon

  MUIButton(
      {Key key,
      @required this.text,
      this.onClick,
      this.size = MUIButtonSize.middle,
      this.type = MUIType.normal,
      this.color,
      this.shape = MUIShape.round,
      this.disabled = false,
      this.backgroundColor,
      this.fontSize = 16,
      this.style})
      : super(key: key);

  @override
  State<MUIButton> createState() => _MUIButtonState();
}

class _MUIButtonState extends State<MUIButton> {
  Color textColor;
  Color bgColor;
  Color borderColor;
  double width = 200;
  double height = 40;

  BoxDecoration boxDecoration;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case MUIType.primary:
        textColor = Colors.white;
        bgColor =
            widget.backgroundColor ?? widget.color ?? MUIColor.purple.color;
        borderColor = widget.color ?? MUIColor.purple.color;
        break;
      case MUIType.danger:
        textColor = Colors.white;
        bgColor = widget.backgroundColor ?? widget.color ?? MUIColor.pink.color;
        borderColor = widget.color ?? MUIColor.pink.color;
        break;
      case MUIType.normal:
        bgColor = widget.backgroundColor ?? Colors.white;
        textColor = widget.color ?? MUIColor.purple.color;
        borderColor = widget.color ?? MUIColor.purple.color;
        break;
    }

    if (widget.disabled) {
      if (widget.type == MUIType.primary) {
        textColor = Colors.white;
        bgColor = widget.color ?? MUIColor.gray.color;
        borderColor = widget.color ?? MUIColor.gray.color;
      } else {
        bgColor = Colors.white;
        textColor = widget.color ?? MUIColor.gray.color;
        borderColor = widget.color ?? MUIColor.gray.color;
      }
    }

    switch (widget.size) {
      case MUIButtonSize.large:
        width = 200;
        height = 50;
        break;
      case MUIButtonSize.middle:
        width = 200;
        height = 40;
        break;
      case MUIButtonSize.small:
        width = 100;
        height = 40;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double getResponseWidth(double originWidth) {
      return originWidth / 375 * MediaQuery.of(context).size.width;
    }

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed:
          (!widget.disabled && widget.onClick != null) ? widget.onClick : () {},
      child: Container(
        width: getResponseWidth(width),
        height: getResponseWidth(height),
        decoration: widget.shape == MUIShape.round
            ? BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(getResponseWidth(25)),
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
              )
            : (widget.shape == MUIShape.rectangle
                ? BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: borderColor,
                      width: 1,
                    ),
                  )
                : BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: 1,
                    ),
                  )),
        child: Center(
          child: Text(
            this.widget.text,
            style: widget.style == null
                ? TextStyle(
                    fontSize: getResponseWidth(widget.fontSize),
                    color: textColor,
                    fontWeight: FontWeight.w500)
                : widget.style,
          ),
        ),
      ),
    );
  }
}
