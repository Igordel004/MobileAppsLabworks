import 'priority.dart';

class Task {
  String _title;
  Priority _priority;
  bool _isCompleted;

  Task(this._title, this._priority) : _isCompleted = false;

  String get title => _title;
  set title(String value) => _title = value;

  Priority get priority => _priority;
  set priority(Priority value) => _priority = value;

  bool get isCompleted => _isCompleted;

  void completeTask() {
    _isCompleted = true;
  }

  String displayInfo() {
    return 'Задача: $_title, Приоритет: ${priority.description}, Завершено: $_isCompleted';
  }
}