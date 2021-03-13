import 'package:VUTTR/styles/index.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'VUTTR',
          key: const Key('AppName'),
          style: TextStyle(
              fontSize: 48.0,
              fontFamily: Font.FONT_FAMILY,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }
}
