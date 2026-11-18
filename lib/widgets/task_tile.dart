import 'package:flutter/material.dart';
import '../models/task.dart';

/// Widget per la visualizzazione di una singola attività nella lista.
/// Mostra chiaramente:
/// - Titolo
/// - Stato (completata / da fare) con Checkbox e Chip
/// - Importanza (evidenziata con icona stella e Chip dorato)
/// - Pulsante per eliminazione (con richiesta conferma)
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
      elevation: task.isImportant ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: task.isImportant
              ? Colors.amber.shade600
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: task.isImportant ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        // Facendo tap sulla riga si può alternare lo stato (Scenario S3)
        onTap: () => onStatusChanged(!task.isCompleted),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox per lo stato (Scenario S3)
              Transform.scale(
                scale: 1.15,
                child: Checkbox(
                  value: task.isCompleted,
                  onChanged: onStatusChanged,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  activeColor: Colors.green.shade600,
                ),
              ),
              const SizedBox(width: 8),

              // Contenuto testuale e indicatori
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titolo dell'attività
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isCompleted
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Badge di Stato e Importanza ben distinguibili
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        // Chip Stato
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: task.isCompleted
                                ? Colors.green.shade50
                                : Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: task.isCompleted
                                  ? Colors.green.shade300
                                  : Colors.blueGrey.shade200,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                task.isCompleted
                                    ? Icons.check_circle_outline
                                    : Icons.radio_button_unchecked,
                                size: 13,
                                color: task.isCompleted
                                    ? Colors.green.shade700
                                    : Colors.blueGrey.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                task.isCompleted ? 'Completata' : 'Da fare',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: task.isCompleted
                                      ? Colors.green.shade800
                                      : Colors.blueGrey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Chip Importanza (se importante)
                        if (task.isImportant)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.amber.shade400,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 13,
                                  color: Colors.amber.shade800,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Importante',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pulsante Eliminazione (Scenario S4)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.red.shade400,
                tooltip: 'Elimina attività',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
