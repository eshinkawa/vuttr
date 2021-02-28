import 'dart:convert';

import 'package:VUTTR/interfaces/tool_repository_interface.dart';
import 'package:VUTTR/models/tool_model.dart';
import 'package:VUTTR/shared/consts_api.dart';
import 'package:http/http.dart' as http;

class ToolRepository implements IToolRepository {
  @override
  Future<List<Tool>> getAllTools() async {
    try {
      List<Tool> listPost = List();
      final response = await http.get(ApiConstants.BASE_URL);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listPost.add(Tool.fromJson(item)));
        return listPost;
      } else {
        print("Error loading tools" + response.statusCode.toString());
        return null;
      }
    } catch (error, stacktrace) {
      print("Error loading tools" + stacktrace.toString());
      return null;
    }
  }

  @override
  Future<List<Tool>> addTool() {
    // TODO: implement addTool
    throw UnimplementedError();
  }

  @override
  Future<List<Tool>> deleteTool() {
    // TODO: implement deleteTool
    throw UnimplementedError();
  }
}
