import 'package:VUTTR/styles/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFieldTool extends StatelessWidget {
  final String title;
  final Function(String text) onChange;

  FormFieldTool({@required this.title, @required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            onChanged: onChange,
            keyboardType: TextInputType.text,
            autofocus: false,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: Font.FONT_FAMILY,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(12.0),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            ),
            onSaved: (String value) {},
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
