import 'package:VUTTR/controller/ToolsController.dart';
import 'package:VUTTR/models/tool_model.dart';
import 'package:VUTTR/styles/index.dart';
import 'package:VUTTR/widgets/card.dart';
import 'package:VUTTR/widgets/delete_dialog.dart';
import 'package:VUTTR/widgets/form_field.dart';
import 'package:VUTTR/widgets/search_bar.dart';
import 'package:VUTTR/widgets/title.dart';
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
    loading = true;
    await _toolsController.deleteTool(id);
    tools = await _toolsController.getAllTools();
    loading = false;
    setState(() {});
    Navigator.of(context).pop();
  }

  addTool(Tool toolItem) async {
    loading = true;
    await _toolsController.addTool(toolItem);
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
          title: title,
          onPressed: () => deleteTool(id, context),
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
                identifierKey: 'NameField',
                title: 'Tool name',
                onChange: (String name) {
                  _name = name;
                  setState(() {});
                },
              ),
              FormFieldTool(
                identifierKey: 'LinkField',
                title: 'Tool link',
                onChange: (String link) {
                  _link = link;
                  setState(() {});
                },
              ),
              FormFieldTool(
                identifierKey: 'DescriptionField',
                title: 'Tool description',
                onChange: (String description) {
                  _description = description;
                  setState(() {});
                },
              ),
              FormFieldTool(
                identifierKey: 'TagsField',
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
              key: const Key('AddToolConfirmButton'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
              ),
              child: Text("Add tool",
                  style: TextStyle(
                    fontFamily: Font.FONT_FAMILY,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {
                addTool(
                  Tool(
                    title: _name,
                    description: _description,
                    link: _link,
                    tags: _tag.split(" "),
                  ),
                );
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
    return Scaffold(
      backgroundColor: Color(0xFF2E3136),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderTitle(),
              SearchBar(
                isOnlyTags: isOnlyTags,
                onChangeText: (query) => queryTool(query),
                onChangeCheckbox: (bool value) {
                  isOnlyTags = value;
                  setState(() {});
                },
              ),
              Container(
                child: loading
                    ? Center(child: CupertinoActivityIndicator())
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
      floatingActionButton: FloatingActionButton(
        key: const Key('AddToolButton'),
        onPressed: () => addToolsDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
