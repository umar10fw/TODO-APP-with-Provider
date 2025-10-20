import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  late List<DateTime> daysInMonth;
  DateTime? selectedDate; // ✅ add this line

  DateSelectorViewModel() {
    _generateDaysForMonth(DateTime.now());
    selectedDate = DateTime.now(); // ✅ default select current date
  }

  String get monthName => DateFormat('MMMM yyyy').format(daysInMonth.first);



  void _generateDaysForMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    daysInMonth = List.generate(
      lastDay.day,
          (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  bool isSelected(DateTime date) {
    if (selectedDate == null) return false;
    return date.year == selectedDate!.year &&
        date.month == selectedDate!.month &&
        date.day == selectedDate!.day;
  }

  void selectDate(DateTime date, double screenWidth) {
    selectedDate = date;
    _scrollToDate(date, screenWidth);
    notifyListeners();
  }

  void _scrollToDate(DateTime date, double screenWidth) {
    final index = daysInMonth.indexWhere((d) =>
    d.day == date.day && d.month == date.month && d.year == date.year);
    if (index != -1) {
      final offset = (index * (screenWidth < 600 ? 72.0 : 80.0));
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
