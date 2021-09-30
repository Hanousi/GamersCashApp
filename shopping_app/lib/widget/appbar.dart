import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Color color;
  final Color textColor;

  const CommonAppBar(
      {Key key, @required this.title, this.color, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: color ?? Colors.grey[100],
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: 20.00),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor ?? Colors.black,
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
