import 'package:flutter/material.dart';

class AddTaskViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;


  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void createTask() {
    debugPrint("Task Created: ${titleController.text}");
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
