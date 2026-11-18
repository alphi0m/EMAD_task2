import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isImportant = false;
  bool _submitted = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        isCompleted: false,
        isImportant: _isImportant,
      );
      Navigator.of(context).pop(task);
    } else {
      setState(() {
        _submitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova Attività'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Titolo dell\'attività *',
                  hintText: 'Cosa devi fare?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.edit_note_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Il titolo è obbligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SwitchListTile(
                  secondary: Icon(
                    _isImportant ? Icons.star : Icons.star_border,
                    color: _isImportant ? Colors.amber.shade500 : null,
                  ),
                  title: const Text(
                    'Attività importante',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('Metti in evidenza nell\'elenco'),
                  value: _isImportant,
                  onChanged: (val) {
                    setState(() {
                      _isImportant = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.check),
                label: const Text(
                  'Salva attività',
                  style: TextStyle(fontSize: 16),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
