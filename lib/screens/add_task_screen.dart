import 'package:flutter/material.dart';
import '../models/task.dart';

/// Schermata per la creazione di una nuova attività (Scenario S1 / Requisito R1).
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isImportant = false;
  bool _autoValidate = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitTask() {
    // Verifica la validità del form
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        isCompleted: false, // Per specifica: una nuova attività è "da fare"
        isImportant: _isImportant,
      );
      // Ritorna l'attività creata alla schermata principale
      Navigator.of(context).pop(newTask);
    } else {
      // Attiva l'autovalidazione continua in modo che l'errore scompaia
      // non appena l'utente corregge il titolo (come richiesto dallo scenario S1 - Variante).
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova Attività'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card informativa
                Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Inserisci i dettagli dell\'attività da svolgere.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Campo Titolo (Obbligatorio)
                TextFormField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Titolo dell\'attività *',
                    hintText: 'Es. Preparare presentazione esame',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.title),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Il titolo è obbligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Opzione Importanza
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _isImportant
                          ? Colors.amber.shade700
                          : theme.colorScheme.outlineVariant,
                      width: _isImportant ? 2 : 1,
                    ),
                  ),
                  child: SwitchListTile(
                    value: _isImportant,
                    onChanged: (bool value) {
                      setState(() {
                        _isImportant = value;
                      });
                    },
                    secondary: Icon(
                      _isImportant ? Icons.star : Icons.star_border,
                      color: _isImportant ? Colors.amber.shade700 : null,
                      size: 28,
                    ),
                    title: const Text(
                      'Attività importante',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      'Contrassegna come prioritaria nell\'elenco',
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Pulsante di conferma (Salva)
                FilledButton.icon(
                  onPressed: _submitTask,
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Crea Attività',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Pulsante Annulla (opzione esplicita per la Variante Rinuncia)
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Annulla'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
