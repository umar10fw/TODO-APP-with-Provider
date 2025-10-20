import 'package:flutter/material.dart';

class AddTaskViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;

  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void selectTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  void createTask(BuildContext context) {
    final formattedTime =
    selectedTime != null ? selectedTime!.format(context) : "No time selected";
    debugPrint("Task Created on $selectedDate at $formattedTime");
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  // void createTask() {
  //   debugPrint("Task Created: ${titleController.text}");
  // }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
