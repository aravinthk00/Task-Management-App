import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted
  });
  
  @override
  List<Object?> get props => [id, title, description, dueDate, isCompleted];

}