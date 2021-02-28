import 'package:VUTTR/models/tool_model.dart';

abstract class IToolRepository {
  Future<List<Tool>> getAllTools();
  Future<List<Tool>> deleteTool();
  Future<List<Tool>> addTool();
}
