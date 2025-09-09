import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
Future<List<Task>> getTasks() async {
  final tasksJson = await localDataSource.getTasks();
  final taskModels = tasksJson.map((json) => TaskModel.fromJson(json)).toList();
  return taskModels.map((model) => model.toEntity()).toList();
}

  @override
  Future<void> addTask(Task task) async {
    final tasksJson = await localDataSource.getTasks();
    tasksJson.add(TaskModel.fromEntity(task).toJson());
    await localDataSource.saveTasks(tasksJson);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasksJson = await localDataSource.getTasks();
    final index = tasksJson.indexWhere((t) => t['id'] == task.id);
    if (index != -1) {
      tasksJson[index] = TaskModel.fromEntity(task).toJson();
      await localDataSource.saveTasks(tasksJson);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final tasksJson = await localDataSource.getTasks();
    tasksJson.removeWhere((t) => t['id'] == id);
    await localDataSource.saveTasks(tasksJson);
  }
}