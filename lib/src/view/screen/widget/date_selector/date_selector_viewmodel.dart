import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorViewModel extends ChangeNotifier {
  late List<DateTime> daysInMonth;
  late DateTime selectedDate;
  final ScrollController scrollController = ScrollController();

  DateSelectorViewModel() {
    _initializeCurrentMonth();
  }

  void initializeSelectedDate(double screenWidth) {
    if (selectedDate == null) {
      final today = DateTime.now();
      final todayIndex = daysInMonth.indexWhere(
            (date) =>
        date.day == today.day &&
            date.month == today.month &&
            date.year == today.year,
      );
      if (todayIndex != -1) {
        selectDate(today, screenWidth);
      }
    }
  }



  /// Always start with today's date when app launches
  void _initializeCurrentMonth() {
    final now = DateTime.now();
    selectedDate = now;
    _generateDaysForMonth(now);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _generateDaysForMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1));

    daysInMonth = List.generate(
      lastDay.day,
          (index) => DateTime(date.year, date.month, index + 1),
    );

    notifyListeners();
  }

  /// When user taps another date, update selection
  void selectDate(DateTime date, double screenWidth) {
    selectedDate = date;
    notifyListeners();
    _scrollToSelectedDate(screenWidth: screenWidth);
  }

  /// Move to next month and select the 1st day of that month
  void goToNextMonth() {
    final nextMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    _generateDaysForMonth(nextMonth);
    selectedDate = nextMonth; // select 1st day of new month
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  /// Move to previous month and select the 1st day of that month
  void goToPreviousMonth() {
    final prevMonth = DateTime(selectedDate.year, selectedDate.month - 1, 1);
    _generateDaysForMonth(prevMonth);
    selectedDate = prevMonth; // select 1st day of previous month
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  bool isSelected(DateTime date) =>
      date.day == selectedDate.day &&
          date.month == selectedDate.month &&
          date.year == selectedDate.year;

  String get monthName => DateFormat('MMMM yyyy').format(selectedDate);

  /// Smoothly center selected date
  Future<void> _scrollToSelectedDate({double? screenWidth, double itemWidth = 75.0}) async {
    if (daysInMonth.isEmpty) return;

    final index = daysInMonth.indexWhere(
          (d) =>
      d.day == selectedDate.day &&
          d.month == selectedDate.month &&
          d.year == selectedDate.year,
    );

    if (index == -1) return;

    final width = screenWidth ??
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
            WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    final target = (index * itemWidth) - (width / 2) + (itemWidth / 2);

    int retries = 0;
    while (!scrollController.hasClients && retries < 10) {
      await Future.delayed(const Duration(milliseconds: 50));
      retries++;
    }

    if (!scrollController.hasClients) return;

    final clamped = target.clamp(
      scrollController.position.minScrollExtent,
      scrollController.position.maxScrollExtent,
    );

    try {
      await scrollController.animateTo(
        clamped,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    } catch (_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(clamped);
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
