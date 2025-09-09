import 'package:flutter/material.dart';
import 'package:pepper_cloud_task_managment_app/domain/repositories/task_repository.dart';

import '../../domain/entities/task.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository taskRepository;
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  TaskProvider({required this.taskRepository});

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await taskRepository.getTasks();
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    await taskRepository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await taskRepository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await taskRepository.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(String id) async {
    final task = _tasks.firstWhere((t) => t.id == id);
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: !task.isCompleted,
    );

    await updateTask(updatedTask);
  }
}
