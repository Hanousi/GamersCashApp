import 'package:animated_text_kit/animated_text_kit.dart';
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
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 24.0,
      fontFamily: 'Horizon',
    );

    return AppBar(
      elevation: 0,
      backgroundColor: color ?? Colors.grey[100],
      titleSpacing: 0.0,
      title: Padding(
        padding: EdgeInsets.only(top: 20.00),
        child: Center(
            child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              title,
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
        )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
