import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/app.dart';
import 'package:shopping_app/resources/app_theme.dart';
import 'package:thememode_selector/thememode_selector.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Color color;
  final Color textColor;

  CommonAppBar({Key key, @required this.title, this.color, this.textColor})
      : super(key: key);

  var isDarkModeEnabled = false;

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
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      titleSpacing: 0.0,
      actions: [
        Container(
            margin: EdgeInsets.only(top: 15, right: 20),
            child: Transform.scale(
                scale: 0.75,
                child: ThemeModeSelector(
                    height: 40,
                    onChanged: (mode) {
                      if (mode == ThemeMode.dark) {
                        MyApp.of(context).changeTheme(buildDarkTheme());
                      } else {
                        MyApp.of(context).changeTheme(buildLightTheme());
                      }
                    })))
      ],
      title: Padding(
        padding: EdgeInsets.only(top: 15.00),
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
