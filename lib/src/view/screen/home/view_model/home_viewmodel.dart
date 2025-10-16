import 'package:flutter/material.dart';
import '../../../../data/models/task_model.dart';

class HomeViewModel extends ChangeNotifier {
  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void updateTask(String id) {
    // Example: open dialog or update field
    print('Update pressed for $id');
  }
  List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      title: 'Fitness',
      description: 'Exercise and gym',
      date: DateTime.now(),
      category: 'Health',
      isCompleted: true,
      startTime: '6:00',
      endTime: '7:30',
    ),
    TaskModel(
      id: '2',
      title: 'Check Emails and SMS',
      description: 'Review and respond to emails and SMS',
      date: DateTime.now(),
      category: 'Work',
      isCompleted: true,
      startTime: '7:30',
      endTime: '8:00',
    ),
    TaskModel(
      id: '3',
      title: 'Work on Projects',
      description: 'Focus on all the tasks related to Project',
      date: DateTime.now(),
      category: 'Work',
      isCompleted: true,
      startTime: '8:00',
      endTime: '10:00',
    ),
    TaskModel(
      id: '4',
      title: 'Attend Meeting',
      description: 'Team meeting with the client ABC',
      date: DateTime.now(),
      category: 'Meeting',
      isCompleted: false,
      startTime: '10:00',
      endTime: '11:00',
    ),
    TaskModel(
      id: '5',
      title: 'Work of XYZ',
      description: 'Change theme and ideas in XYZ',
      date: DateTime.now(),
      category: 'Work',
      isCompleted: false,
      startTime: '11:00',
      endTime: '13:00',
    ),
    TaskModel(
      id: '6',
      title: 'Lunch Break',
      description: 'Enjoy a healthy lunch and take some rest',
      date: DateTime.now(),
      category: 'Break',
      isCompleted: false,
      startTime: '13:00',
      endTime: '14:30',
    ),
  ];

  List<TaskModel> get tasks => _tasks;

  void toggleTask(String id) {
    int index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
      notifyListeners();
    }
  }
}
