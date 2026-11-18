/// Rappresenta l'entità principale del dominio: l'Attività (Task).
/// 
/// Campi previsti dalla traccia:
/// - [id]: identificatore univoco del task.
/// - [title]: testo obbligatorio che descrive l'attività.
/// - [isCompleted]: stato (completata o da fare, default: da fare).
/// - [isImportant]: se l'attività è importante o no (default: no).
class Task {
  final String id;
  String title;
  bool isCompleted;
  bool isImportant;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.isImportant = false,
  });

  /// Metodo copyWith per creare una copia aggiornata (best practice Flutter).
  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    bool? isImportant,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isImportant: isImportant ?? this.isImportant,
    );
  }
}
