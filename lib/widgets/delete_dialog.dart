import 'package:VUTTR/styles/index.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final Function onPressed;

  DeleteDialog({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.indigo,
      title: Text("REMOVE TOOL",
          style: TextStyle(
              fontFamily: Font.FONT_FAMILY,
              fontWeight: FontWeight.w700,
              color: Colors.white)),
      content: Text("Are you sure you want to remove ${title}",
          style: TextStyle(
              fontFamily: Font.FONT_FAMILY,
              fontWeight: FontWeight.w400,
              color: Colors.white)),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Cancel",
              style: TextStyle(
                fontFamily: Font.FONT_FAMILY,
                fontWeight: FontWeight.w600,
              )),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
            onPrimary: Colors.white, // foreground
          ),
          child: Text("Yes, remove",
              style: TextStyle(
                fontFamily: Font.FONT_FAMILY,
                fontWeight: FontWeight.w600,
              )),
          onPressed: onPressed,
        )
      ],
    );
  }
}
