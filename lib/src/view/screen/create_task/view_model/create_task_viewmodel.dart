import 'package:flutter/material.dart';

import '../../add_task/add_task_screen.dart';

class CategoryModel {
  final String name;
  final int taskCount;
  final IconData icon;

  CategoryModel({required this.name, required this.taskCount, required this.icon});
}

class CreateTaskViewModel extends ChangeNotifier {
  final List<CategoryModel> categories = [
    CategoryModel(name: 'Idea', taskCount: 12, icon: Icons.lightbulb_outline),
    CategoryModel(name: 'Food', taskCount: 9, icon: Icons.fastfood_outlined),
    CategoryModel(name: 'Work', taskCount: 14, icon: Icons.work_outline),
    CategoryModel(name: 'Sport', taskCount: 5, icon: Icons.fitness_center_outlined),
    CategoryModel(name: 'Music', taskCount: 4, icon: Icons.music_note_outlined),
  ];

  void selectCategory(BuildContext context, CategoryModel category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(selectedCategory: category.name),
      ),
    );
  }
}
