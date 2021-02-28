import 'package:VUTTR/controller/ToolsController.dart';
import 'package:VUTTR/models/tool_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _toolsController = ToolsController();
  List<Tool> tools;

  fetchData() async {
    tools = await _toolsController.getAllTools();
    setState(() {});
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
        body: ListView.builder(
          itemCount: tools.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${tools[index].description}'),
            );
          },
        ),
      ),
    );
  }
}
