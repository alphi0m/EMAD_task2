import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

/// Schermata principale: Elenco delle attività (Scenari S2, S3, S4).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista delle attività memorizzata nello stato del widget
  final List<Task> _tasks = [];

  // Calcolo delle attività completate
  int get _completedCount => _tasks.where((t) => t.isCompleted).length;
  int get _totalCount => _tasks.length;

  /// Scenario S1: Apertura schermata creazione e gestione risultato.
  Future<void> _navigateAndAddTask() async {
    final Task? newTask = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    // Se l'utente ha confermato la creazione:
    // aggiunge l'attività e mostra un messaggio temporaneo di conferma (SnackBar).
    // Se l'utente ha rinunciato (newTask == null), l'elenco rimane invariato senza messaggi.
    if (newTask != null && mounted) {
      setState(() {
        _tasks.add(newTask);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attività "${newTask.title}" aggiunta!'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  /// Scenario S3: Aggiornamento immediato dello stato e del conteggio.
  void _toggleTaskStatus(int index, bool? isCompleted) {
    setState(() {
      _tasks[index].isCompleted = isCompleted ?? !_tasks[index].isCompleted;
    });
  }

  /// Scenario S4: Eliminazione con richiesta di conferma e gestione della variante rinuncia.
  Future<void> _confirmDeleteTask(int index) async {
    final task = _tasks[index];

    // Mostra il dialogo di conferma
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 8),
              Text('Elimina attività'),
            ],
          ),
          content: Text(
            'Sei sicuro di voler eliminare "${task.title}"?\nQuesta operazione non può essere annullata.',
          ),
          actions: [
            // Variante Rinuncia: rifiuto della conferma
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Annulla'),
            ),
            // Conferma eliminazione
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade600,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Elimina'),
            ),
          ],
        );
      },
    );

    // Se confermato, rimuove l'attività e aggiorna subito l'elenco e il conteggio
    if (confirmed == true && mounted) {
      setState(() {
        _tasks.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attività "${task.title}" eliminata'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
    // Se non confermato (rinuncia), non fa nulla: l'elenco resta invariato.
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scheda Conteggio (Scenario S2: "numero di attività completate sul totale")
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    radius: 20,
                    child: const Icon(Icons.checklist_rounded, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Avanzamento attività',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$_completedCount su $_totalCount completate',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_totalCount > 0)
                    Text(
                      '${((_completedCount / _totalCount) * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),

            // Elenco o Variante "nessuna attività"
            Expanded(
              child: _tasks.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fact_check_outlined,
                              size: 72,
                              color: theme.colorScheme.outline.withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Nessuna attività presente',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tocca il pulsante "+" in basso a destra per aggiungere la tua prima attività.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 20),
                            FilledButton.tonalIcon(
                              onPressed: _navigateAndAddTask,
                              icon: const Icon(Icons.add),
                              label: const Text('Aggiungi attività'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      padding: const EdgeInsets.only(top: 4, bottom: 80),
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return TaskTile(
                          key: ValueKey(task.id),
                          task: task,
                          onStatusChanged: (value) =>
                              _toggleTaskStatus(index, value),
                          onDelete: () => _confirmDeleteTask(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      // Pulsante per avviare la creazione di una nuova attività (Scenario S1)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateAndAddTask,
        icon: const Icon(Icons.add),
        label: const Text('Nuova Attività'),
      ),
    );
  }
}
