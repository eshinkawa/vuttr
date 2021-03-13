import 'package:VUTTR/styles/index.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    @required this.isOnlyTags,
    @required this.onChangeText,
    @required this.onChangeCheckbox,
  });

  final bool isOnlyTags;
  final Function onChangeText;
  final Function onChangeCheckbox;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('SearchbarWidget'),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: Colors.white),
          borderRadius: BorderRadius.circular(32.0)),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: TextFormField(
              key: const Key('SearchInputKey'),
              onChanged: onChangeText,
              keyboardType: TextInputType.text,
              autofocus: false,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: Font.FONT_FAMILY,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'search',
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.all(0.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              // validator: FormValidator().validateEmail,
              onSaved: (String value) {},
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text('only tags',
                    style: TextStyle(
                        fontFamily: Font.FONT_FAMILY,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Checkbox(
                  key: const Key('Checkbox'),
                  checkColor: Colors.white, // color of tick Mark
                  activeColor: Colors.grey,
                  value: isOnlyTags,
                  onChanged: onChangeCheckbox,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
