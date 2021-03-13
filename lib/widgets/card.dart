import 'package:VUTTR/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolCard extends StatelessWidget {
  ToolCard({
    @required this.title,
    @required this.description,
    @required this.tags,
    @required this.link,
    @required this.onDelete,
  });

  final String title;
  final String description;
  final String link;
  final List<String> tags;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await launch(link),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Card(
          color: Color(0xFF3D3D3D).withOpacity(0.1),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                trailing: IconButton(
                    key: const Key('DeleteCardIcon'),
                    color: Colors.white,
                    icon: Icon(Icons.close),
                    onPressed: onDelete),
                title: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: Font.FONT_FAMILY,
                        fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: Font.FONT_FAMILY,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: [
                      ...tags.map(
                        (tag) => Text(
                          '#$tag ',
                          style: TextStyle(
                            fontFamily: Font.FONT_FAMILY,
                            fontWeight: FontWeight.w800,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
