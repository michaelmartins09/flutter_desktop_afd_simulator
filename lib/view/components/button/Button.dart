import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Button extends StatelessWidget {
  final double size;
  final Color color;
  final IconData iconData;
  final String title;
  final Function onTap;
  final bool current;
  final colorTitle;

  const Button({
    Key key, 
    this.size, 
    this.color, 
    this.onTap, 
    this.current = false,
    this.colorTitle,
    @required this.iconData, 
    @required this.title, 
  }) : super(key: key);

  final defaultSize = 45.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? defaultSize,
      decoration: BoxDecoration(
        color: onTap != null ? color ?? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          hoverColor: Theme.of(context).backgroundColor.withOpacity(0.4),
          onTap: onTap,
          onTapCancel: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title ?? "title", style: TextStyle(color: colorTitle ?? Theme.of(context).scaffoldBackgroundColor, fontSize: 18), textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Icon(iconData ?? Icons.title, color: colorTitle ?? Theme.of(context).scaffoldBackgroundColor, size: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
