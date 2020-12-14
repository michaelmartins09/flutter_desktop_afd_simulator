import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HeadlineButton extends StatelessWidget {
  final Color color;
  final String title;
  final int number;
  final bool current;
  final Function onTap;
  final bool isCompleted;

  const HeadlineButton({Key key, this.color, this.title, this.number, this.current = false, this.onTap, this.isCompleted = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: current ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onHighlightChanged: (bool) => onTap(),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                isCompleted ? Icon(
                  FeatherIcons.checkCircle,
                  color: color ?? Theme.of(context).primaryColor,
                  size: 26,
                ) : Text(number?.toString() ?? "0", style: TextStyle(
                  fontSize: 28, color: Theme.of(context).primaryColor
                )),
                SizedBox(width: isCompleted ? 11 : number == 1? 24 : 20),
                Container(
                  height: 50,
                  width: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color ?? Theme.of(context).primaryColor
                  ),
                ),
                SizedBox(width: 20),
                Text(title ?? "Headline", style: TextStyle(
                  fontSize: 28
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
