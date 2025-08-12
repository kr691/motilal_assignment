import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/task_model.dart';

class TaskRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/todos?_limit=20'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<void> addTask(TaskModel task) async {
    await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
  }

  Future<void> updateTask(TaskModel task) async {
    await http.put(
      Uri.parse('$baseUrl/todos/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
  }

  Future<void> deleteTask(int id) async {
    await http.delete(Uri.parse('$baseUrl/todos/$id'));
  }
}
