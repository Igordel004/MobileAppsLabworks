import 'dart:async';
import 'task.dart';
import 'priority.dart';

class TaskManager<T extends Task> {
  List<T> tasks = [];
  Map<Priority, List<T>> priorityTasks = {};

  TaskManager() {
    for (var priority in Priority.values) {
      priorityTasks[priority] = [];
    }

    List<String> sampleTitles = ['Написать отчёт', 'Посетить встречу', 'Отдохнуть', 'Убраться дома'];
    for (int i = 0; i < sampleTitles.length; i++) {
      var task = Task(sampleTitles[i], Priority.values[i % 3]) as T;
      tasks.add(task);
      priorityTasks[task.priority]!.add(task);
    }
  }

  Future<String> processTasks() async {
    StringBuffer result = StringBuffer();
    int index = 0;

    while (index < tasks.length) {
      var task = tasks[index];
      await Future.delayed(Duration(milliseconds: 500), () {
        task.completeTask();
      });
      result.write('${task.displayInfo()}\n');
      index++;
    }

    priorityTasks.forEach((priority, taskList) {
      result.write(
          '${priority.description}: ${taskList.length} задач\n');
    });

    return result.toString();
  }
}