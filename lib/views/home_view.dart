import 'package:VUTTR/controller/ToolsController.dart';
import 'package:VUTTR/models/tool_model.dart';
import 'package:VUTTR/styles/index.dart';
import 'package:VUTTR/widgets/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _toolsController = ToolsController();
  List<Tool> tools;
  bool loading = false;
  bool isOnlyTags = false;

  fetchData() async {
    loading = true;
    tools = await _toolsController.getAllTools();
    loading = false;
    setState(() {});
  }

  queryTool(String query) async {
    loading = true;
    if (isOnlyTags) {
      tools = await _toolsController.searchToolByQuery(query);
    } else {
      tools = await _toolsController.searchToolByTerm(query);
    }
    loading = false;
    setState(() {});
  }

  deleteTool(int id, BuildContext context) async {
    print(id);
    loading = true;
    await _toolsController.deleteTool(id);
    tools = await _toolsController.getAllTools();
    loading = false;
    setState(() {});
    Navigator.of(context).pop();
  }

  deleteConfirmation(String title, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("REMOVE TOOL",
              style: TextStyle(
                fontFamily: Font.FONT_FAMILY,
                fontWeight: FontWeight.w700,
              )),
          content: Text("Are you sure you want to remove ${title}",
              style: TextStyle(
                fontFamily: Font.FONT_FAMILY,
                fontWeight: FontWeight.w400,
              )),
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
              child: Text("Yes, remove",
                  style: TextStyle(
                    fontFamily: Font.FONT_FAMILY,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {
                deleteTool(id, context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'VUTTR',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontFamily: Font.FONT_FAMILY,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                      borderRadius: BorderRadius.circular(32.0)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          onChanged: (query) => queryTool(query),
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: Font.FONT_FAMILY,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'search',
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
                                )),
                            Checkbox(
                              value: isOnlyTags,
                              onChanged: (bool value) {
                                isOnlyTags = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                              onDelete: () => deleteConfirmation(
                                    tools[index].title,
                                    tools[index].id,
                                  )),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
