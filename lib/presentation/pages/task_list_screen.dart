import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/empty_tasks_state.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showCompleted = true;
  String _sortBy = 'dueDate';
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // Refresh UI when search text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Task> _filterAndSortTasks(List<Task> tasks) {
    // Filter by search query
    List<Task> filteredTasks = tasks.where((task) {
      final searchQuery = _searchController.text.toLowerCase();
      return task.title.toLowerCase().contains(searchQuery) ||
          task.description.toLowerCase().contains(searchQuery);
    }).toList();

    // Filter by completion status
    if (!_showCompleted) {
      filteredTasks = filteredTasks.where((task) => task.isCompleted).toList();
    }

    // Sort tasks
    filteredTasks.sort((a, b) {
      int comparison = 0;

      switch (_sortBy) {
        case 'dueDate':
          comparison = a.dueDate.compareTo(b.dueDate);
          break;
        default: // 'id' or default
          comparison = a.id.compareTo(b.id);
          break;
      }

      return _sortAscending ? comparison : -comparison;
    });

    return filteredTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: Column(
        children: [
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search tasks...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filter button for completed tasks
                FilterChip(
                  label: Text(_showCompleted ? 'All Tasks' : 'Completed Tasks'),
                  side: BorderSide(
                    color: Colors.grey
                  ),
                  selected: !_showCompleted,
                  onSelected: (selected) {
                    setState(() {
                      _showCompleted = !selected;
                    });
                  },
                  avatar: Icon(
                    _showCompleted ? Icons.visibility : Icons.visibility_off,
                    size: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Due Date',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    IconButton(
                      icon: Icon(
                        _sortAscending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _sortAscending = !_sortAscending;
                          _sortBy = 'dueDate';
                        });
                      },
                      tooltip: _sortAscending ? 'Ascending' : 'Descending',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                if (taskProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                final filteredTasks = _filterAndSortTasks(taskProvider.tasks);

                if (filteredTasks.isEmpty) {
                  if (_searchController.text.isNotEmpty || !_showCompleted) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tasks found',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filter',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  }
                  return EmptyTasksState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return TaskItem(
                      task: task,
                      onToggleComplete: () =>
                          taskProvider.toggleTaskCompletion(task.id),
                      onEdit: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(task: task),
                        ),
                      ),
                      onDelete: () =>
                          _showDeleteDialog(context, taskProvider, task.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    TaskProvider taskProvider,
    String taskId,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                taskProvider.deleteTask(taskId);
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
