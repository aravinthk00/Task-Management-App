import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pepper_cloud_task_managment_app/core/constants/app_theme.dart';
import 'package:pepper_cloud_task_managment_app/data/datasources/local_data_source.dart';
import 'package:pepper_cloud_task_managment_app/data/repositories/task_repository_impl.dart';
import 'package:pepper_cloud_task_managment_app/domain/repositories/task_repository.dart';
import 'package:pepper_cloud_task_managment_app/presentation/pages/task_list_screen.dart';
import 'package:pepper_cloud_task_managment_app/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TaskRepository>(
          create: (_) => TaskRepositoryImpl(localDataSource: LocalDataSource()),
          ),
          ChangeNotifierProvider(
            create: (context) => TaskProvider(taskRepository: context.read<TaskRepository>(),
            )..loadTasks())
      ],
      child: MaterialApp(
        title: 'Pepper Cloud Task Manager',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: TaskListScreen(),
      ),
    );
  }
}
