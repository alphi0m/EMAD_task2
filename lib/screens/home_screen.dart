import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];

  int get _completedCount => _tasks.where((t) => t.isCompleted).length;
  int get _totalCount => _tasks.length;

  void _addTask() async {
    final newTask = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (newTask != null && mounted) {
      setState(() {
        _tasks.add(newTask);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attività "${newTask.title}" aggiunta'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _toggleTask(int index, bool? value) {
    setState(() {
      _tasks[index].isCompleted = value ?? !_tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) async {
    final task = _tasks[index];
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina attività'),
        content: Text('Vuoi davvero eliminare "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _tasks.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allCompleted = _totalCount > 0 && _completedCount == _totalCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            tooltip: widget.isDarkMode ? 'Passa al tema chiaro' : 'Passa al tema scuro',
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          // Scheda contatore attività completate
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Attività completate: $_completedCount su $_totalCount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (allCompleted) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Tutto completato! Ottimo lavoro 🎉',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Lista delle attività o messaggio per lista vuota
          Expanded(
            child: _tasks.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checklist,
                            size: 64,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Nessuna attività presente',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Premi il pulsante in basso per aggiungerne una.',
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        key: ValueKey(_tasks[index].id),
                        task: _tasks[index],
                        onStatusChanged: (val) => _toggleTask(index, val),
                        onDelete: () => _deleteTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Aggiungi attività',
        child: const Icon(Icons.add),
      ),
    );
  }
}
