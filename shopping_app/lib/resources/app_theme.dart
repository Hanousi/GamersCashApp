import 'package:flutter/material.dart';

import 'colors.dart';

const minorText = TextStyle(
  color: Color.fromRGBO(128, 128, 128, 1),
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const minorTextBold = TextStyle(
  color: Color.fromRGBO(128, 128, 128, 1),
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);


const smallText = TextStyle(
  color: Colors.grey,
  fontSize: 12,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const minorTextWhite = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: AppColors.white,
        fontSize: 24,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: AppColors.white,
        fontSize: 26,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    )
  );
}

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: const TextTheme(
          headline1: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        headline2: TextStyle(
          color: AppColors.black,
          fontSize: 26,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
      )
  );
}

const headingText = TextStyle(
  color: AppColors.black,
  fontSize: 24,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const prizeText = TextStyle(
  color: AppColors.white,
  fontSize: 24,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const headingTextWhite = TextStyle(
  color: AppColors.white,
  fontSize: 24,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const headingText1 = TextStyle(
  color: AppColors.black,
  fontSize: 30,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const whiteText = TextStyle(
  color: AppColors.white,
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const boldTextMedium = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const textMedium = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
const textMediumWhite = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.white
);