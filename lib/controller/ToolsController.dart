import 'dart:convert';
import 'dart:io';

import 'package:VUTTR/models/tool_model.dart';
import 'package:VUTTR/shared/consts_api.dart';
import 'package:http/http.dart' as http;

class ToolsController {
  String baseUrl = Platform.isIOS
      ? ApiConstants.BASE_URL_IOS
      : ApiConstants.BASE_URL_ANDROID;

  Future<List<Tool>> getAllTools() async {
    try {
      List<Tool> listTools = [];
      final response = await http.get(baseUrl);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listTools.add(Tool.fromJson(item)));
        return listTools;
      } else {
        print("Error loading tools" + response.statusCode.toString());
        return null;
      }
    } catch (error) {
      print("Error loading tools" + error.toString());
      return null;
    }
  }

  Future<List<Tool>> searchToolByTerm(String term) async {
    List<Tool> listTools = [];
    try {
      final response = await http.get('$baseUrl?q=$term');
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listTools.add(Tool.fromJson(item)));
        return listTools;
      } else {
        print("Error loading tools" + response.statusCode.toString());
        return null;
      }
    } catch (error) {
      print("Error loading tools" + error.toString());
      return null;
    }
  }

  Future<List<Tool>> searchToolByQuery(String query) async {
    List<Tool> listTools = [];
    try {
      final response = await http.get('$baseUrl?tags_like=$query');
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listTools.add(Tool.fromJson(item)));
        return listTools;
      } else {
        print("Error loading tools" + response.statusCode.toString());
        return null;
      }
    } catch (error) {
      print("Error loading tools" + error.toString());
      return null;
    }
  }

  Future<String> deleteTool(int id) async {
    try {
      final response = await http.delete('$baseUrl/$id');
      if (response.statusCode == 200) {
        return 'Item with id ${id} was deleted';
      } else {
        print("Error loading tools" + response.statusCode.toString());
        return 'Item with id ${id} was not deleted';
      }
    } catch (error) {
      print("Error loading tools" + error.toString());
      return 'Item with id ${id} was not deleted';
    }
  }

  Future<String> addTool(Tool toolItem) async {
    try {
      final response = await http.post(
        baseUrl,
        body: toolItem.toJson(),
      );
      if (response.statusCode == 200) {
        return 'Item created successfully';
      } else {
        print("Error loading tools" + response.statusCode.toString());
        return 'Item not created';
      }
    } catch (error) {
      print("Error loading tools" + error.toString());
      return 'Item not created';
    }
  }
}
