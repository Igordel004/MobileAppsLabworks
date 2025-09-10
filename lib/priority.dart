enum Priority { low, medium, high }

extension PriorityExtension on Priority {
  String get description {
    return switch (this) {
      Priority.low => 'Низкий',
      Priority.medium => 'Средний',
      Priority.high => 'Высокий'
    };
  }
}