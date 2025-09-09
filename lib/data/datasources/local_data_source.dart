import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource{
  static const _taskKey = 'tasks';

  Future<List<Map<String, dynamic>>> getTasks() async{
    final pref = await SharedPreferences.getInstance();
    final taskJson = pref.getStringList(_taskKey) ?? [];
    return taskJson.map((json) => jsonDecode(json) as Map<String, dynamic>).toList();
  }

  Future<void> saveTasks(List<Map<String, dynamic>> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskJson = tasks.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList(_taskKey, taskJson);
  }
}