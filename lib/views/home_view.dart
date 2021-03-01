import 'package:VUTTR/controller/ToolsController.dart';
import 'package:VUTTR/models/tool_model.dart';
import 'package:VUTTR/styles/index.dart';
import 'package:VUTTR/widgets/card.dart';
import 'package:VUTTR/widgets/delete_dialog.dart';
import 'package:VUTTR/widgets/form_field.dart';
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
  String _name;
  String _link;
  String _description;
  String _tag;
  List<String> _tags;

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
        return DeleteDialog(
            title: title, onPressed: () => deleteTool(id, context),
        );
      },
    );
  }

  addToolsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo,
          title: Text("Add new tool",
              style: TextStyle(
                  fontFamily: Font.FONT_FAMILY,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          content: Column(
            children: [
              FormFieldTool(
                title: 'Tool name',
                onChange: (String name) {
                  _name = name;
                  setState(() {});
                },
              ),
              FormFieldTool(
                title: 'Tool link',
                onChange: (String link) {
                  _name = link;
                  setState(() {});
                },
              ),
              FormFieldTool(
                title: 'Tool description',
                onChange: (String description) {
                  _description = description;
                  setState(() {});
                },
              ),
              FormFieldTool(
                title: 'Tags',
                onChange: (String tags) {
                  _tag = tags;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
              ),
              child: Text("Add tool",
                  style: TextStyle(
                    fontFamily: Font.FONT_FAMILY,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {},
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
      theme: ThemeData(
        unselectedWidgetColor: Colors.white, // <-- your color
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF2E3136),
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
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
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
                          onChanged: (query) => queryTool(query),
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
                              checkColor: Colors.white, // color of tick Mark
                              activeColor: Colors.grey,
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
                    itemBuilder: (context, index) =>
                        ToolCard(
                            title: tools[index].title,
                            description: tools[index].description,
                            tags: tools[index].tags,
                            link: tools[index].link,
                            onDelete: () =>
                                deleteConfirmation(
                                  tools[index].title,
                                  tools[index].id,
                                )),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addToolsDialog(),
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
