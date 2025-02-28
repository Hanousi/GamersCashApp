import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_app/feature/credit_card_details/models/credit_card_model.dart';
import 'package:shopping_app/resources/R.dart';

class CreditCardWidget extends StatelessWidget {
  CreditCardWidget({
    Key key,
    @required this.creditCard,
    this.height,
    this.width,
    this.textStyle,
    this.cardBgColor = const Color(0xff1b447b),
  })  : assert(creditCard != null),
        super(key: key);
  final CreditCard creditCard;
  final TextStyle textStyle;
  final Color cardBgColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return buildFrontContainer(width, height, context, orientation);
  }

  ///
  /// Builds a front container containing
  /// Card number, Exp. year and Card holder name
  ///
  Container buildFrontContainer(
    double width,
    double height,
    BuildContext context,
    Orientation orientation,
  ) {
    final TextStyle defaultTextStyle =
          TextStyle(
            color: Colors.white,
            fontFamily: 'halter',
            fontSize: 16,
          );


    return Container(
      margin: const EdgeInsets.all(16),
      width: width ?? width,
      height: height ??
          (orientation == Orientation.portrait ? height / 4 : height / 2),
      child: Stack(
        children: <Widget>[
          getRandomBackground(height, width, creditCard.color),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 0),
                  blurRadius: 12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  getChipImage(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: getCardTypeIcon(creditCard.cardNumber),
                    ),
                  ),
                ],),

                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    creditCard.cardNumber.isEmpty ||
                            creditCard.cardNumber == null
                        ? 'XXXX XXXX XXXX XXXX'
                        : creditCard.cardNumber,
                    style: textStyle ?? defaultTextStyle,
                  ),
                ),
                Container(
                  height: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 6),
                            child: Text(
                              'Card holder',
                              style: TextStyle(
                                color: Colors.white38,
                                fontFamily: 'halter',
                                fontSize: 9,
                                package: 'credit_card',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              child: Text(
                                creditCard.cardHolderName.isEmpty ||
                                    creditCard.cardHolderName == null
                                    ? 'CARD HOLDER'
                                    : creditCard.cardHolderName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'credit_card',
                                ),
                              ),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 6, right: 32),
                            child: Text(
                              'Expiry',
                              style: TextStyle(
                                color: Colors.white38,
                                fontFamily: 'halter',
                                fontSize: 9,
                                package: 'credit_card',
                              ),
                            ),
                          ),
                          Text(
                            creditCard.expiryDate.isEmpty ||
                                creditCard.expiryDate == null
                                ? 'MM/YY'
                                : creditCard.expiryDate,
                            style: textStyle ?? defaultTextStyle,
                          ),
                        ],
                      )

                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        icon = Image.asset(
          R.icon.visaCard,
          height: 64,
          width: 64,
        );
        break;

      case CardType.americanExpress:
        icon = Image.asset(
          R.icon.amexCard,
          height: 64,
          width: 64,
        );
        break;

      case CardType.mastercard:
        icon = Image.asset(
          R.icon.masterCard,
          height: 64,
          width: 64,
        );
        break;

      case CardType.discover:
        icon = Image.asset(
          R.icon.discoverCard,
          height: 64,
          width: 64,
        );
        break;

      default:
        icon = Container(
          height: 64,
          width: 64,
        );
        break;
    }

    return icon;
  }
}

enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
}


Container getRandomBackground(double height, double width, MaterialColor color) {
  return Container(
    child: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: color,
            )
          ),
        )
      ],
    ),
  );
}

Container getChipImage() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: Image.asset(
      R.icon.chip,
      height: 52,
      width: 52,
    ),
  );
}

/// Credit Card prefix patterns as of March 2019
/// A [List<String>] represents a range.
/// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
Map<CardType, Set<List<String>>> cardNumPatterns =
    <CardType, Set<List<String>>>{
  CardType.visa: <List<String>>{
    <String>['4'],
  },
  CardType.americanExpress: <List<String>>{
    <String>['34'],
    <String>['37'],
  },
  CardType.discover: <List<String>>{
    <String>['6011'],
    <String>['622126', '622925'],
    <String>['644', '649'],
    <String>['65']
  },
  CardType.mastercard: <List<String>>{
    <String>['51', '55'],
    <String>['2221', '2229'],
    <String>['223', '229'],
    <String>['23', '26'],
    <String>['270', '271'],
    <String>['2720'],
  },
};
