import 'dart:convert';
import 'dart:io';

import 'package:VUTTR/models/tool_model.dart';
import 'package:VUTTR/shared/consts_api.dart';
import 'package:http/http.dart' as http;

class ToolsController {
  String BASE_URL = Platform.isIOS
      ? ApiConstants.BASE_URL_IOS
      : ApiConstants.BASE_URL_ANDROID;
  Future<List<Tool>> getAllTools() async {
    try {
      print('hello');
      List<Tool> listTools = List();
      final response = await http.get(BASE_URL);
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
}
