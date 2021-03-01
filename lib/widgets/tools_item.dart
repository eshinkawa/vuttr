import 'package:VUTTR/models/tool_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card.dart';

class ToolsList extends StatelessWidget {
  final bool loading;
  final List<Tool> tools;
  final Function onDelete;

  ToolsList({
    @required this.loading,
    @required this.tools,
    @required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(child: CupertinoActivityIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: tools.length,
              itemBuilder: (context, index) => ToolCard(
                  title: tools[index].title,
                  description: tools[index].description,
                  tags: tools[index].tags,
                  link: tools[index].link,
                  onDelete: onDelete),
            ),
    );
  }
}
