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
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: task.isImportant
              ? Colors.amber.shade600
              : Colors.transparent,
          width: task.isImportant ? 1.5 : 0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Checkbox(
          value: task.isCompleted,
          activeColor: Colors.green.shade600,
          onChanged: onStatusChanged,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted
                ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                : theme.colorScheme.onSurface,
            fontWeight: task.isImportant ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              task.isCompleted ? 'Completata' : 'Da fare',
              style: TextStyle(
                color: task.isCompleted
                    ? Colors.green.shade400
                    : theme.colorScheme.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (task.isImportant) ...[
              const SizedBox(width: 10),
              Icon(Icons.star, color: Colors.amber.shade500, size: 16),
              const SizedBox(width: 2),
              Text(
                'Importante',
                style: TextStyle(
                  color: Colors.amber.shade500,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
          tooltip: 'Elimina',
          onPressed: onDelete,
        ),
      ),
    );
  }
}
