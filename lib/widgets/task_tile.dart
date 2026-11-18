import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onStatusChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: task.isImportant ? 2 : 1,
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onStatusChanged,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : Colors.black87,
            fontWeight: task.isImportant ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              task.isCompleted ? 'Completata' : 'Da fare',
              style: TextStyle(
                color: task.isCompleted ? Colors.green.shade700 : Colors.blueGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (task.isImportant) ...[
              const SizedBox(width: 10),
              Icon(Icons.star, color: Colors.amber.shade700, size: 16),
              const SizedBox(width: 2),
              Text(
                'Importante',
                style: TextStyle(
                  color: Colors.amber.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
