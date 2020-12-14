import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ButtonCircle extends StatelessWidget {
  final double size;
  final Color color;
  final String title;
  final Function onTap;
  final bool current;
  final colorTitle;
  final double fontSize;

  const ButtonCircle({
    Key key, 
    this.size, 
    this.color, 
    this.onTap, 
    this.current = false,
    this.fontSize,
    this.colorTitle,
    @required this.title, 
  }) : super(key: key);

  final defaultSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? defaultSize,
      width: size ?? defaultSize,
      decoration: BoxDecoration(
        color: onTap != null ? color ?? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4),
        shape: BoxShape.circle
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Theme.of(context).backgroundColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(defaultSize),
          onTap: onTap,
          onTapCancel: onTap,
          child: Center(
            child: Text(title ?? "title", style: TextStyle(color: colorTitle ?? Theme.of(context).scaffoldBackgroundColor, fontSize: fontSize ?? 16), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
