import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomDialog extends StatelessWidget {
  final String title;
  final Widget child;

  const BottomDialog({
    Key key,
    this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      color: Theme.of(context).accentColor,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Ionicons.ios_close_circle_outline),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(20), child: child),
                scrollDirection: Axis.vertical,
              ),
            )),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 8,
                  sigmaY: 8,
                ),
                child: Container(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
