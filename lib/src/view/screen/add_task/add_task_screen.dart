import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/src/view/screen/add_task/view_model/add_task_viewmodel.dart';
import '../../../core/constant/color.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/utils/responsive.dart';
import 'package:intl/intl.dart';

import '../create_task/view_model/create_task_viewmodel.dart';

class AddTaskScreen extends StatelessWidget {
  final String selectedCategory;
  const AddTaskScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final theme = Theme.of(context);
    final vm = Provider.of<AddTaskViewModel>(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Task",
                    style: theme.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Calendar
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TableCalendar(
                  focusedDay: vm.selectedDate,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2100),
                  selectedDayPredicate: (day) =>
                      isSameDay(day, vm.selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    vm.selectDate(selectedDay);
                  },
                  availableGestures: AvailableGestures.all,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(
                      color: theme.colorScheme.error.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                    defaultTextStyle: TextStyle(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left,
                        color: theme.colorScheme.onSurface),
                    rightChevronIcon: Icon(Icons.chevron_right,
                        color: theme.colorScheme.onSurface),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // 🕒 Time Selector
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primary, size: 28.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        vm.selectedTime != null
                            ? DateFormat('hh:mm a').format(
                            DateTime(0, 1, 1, vm.selectedTime!.hour, vm.selectedTime!.minute))
                            : "Select Time",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: vm.selectedTime ?? TimeOfDay.now(),
                        );
                        if (picked != null) {
                          vm.selectTime(picked);
                        }
                      },
                      child: Text(
                        "Choose",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Category
              GestureDetector(
                onTap: () => _showCategoryBottomSheet(context), // ✅ open bottom sheet on tap
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: AppColors.primary, size: 28.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          Provider.of<AddTaskViewModel>(context).selectedCategory ??
                              "Select Category", // ✅ dynamic text update
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down,
                          color: theme.iconTheme.color, size: 28.sp),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 20.h),

              // Title
              TextField(
                controller: vm.titleController,
                decoration: InputDecoration(
                  hintText: "Name",
                  filled: true,
                  fillColor: theme.cardTheme.color,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Description
              TextField(
                controller: vm.descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Task Description...",
                  filled: true,
                  fillColor: theme.cardTheme.color,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  onPressed: () => vm.createTask(
                    context
                  ),
                  child: Text(
                    "Create Task",
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void _showCategoryBottomSheet(BuildContext context) {
  final theme = Theme.of(context);
  final createVm = Provider.of<CreateTaskViewModel>(context, listen: false);
  final addVm = Provider.of<AddTaskViewModel>(context, listen: false);

  showModalBottomSheet(
    context: context,
    backgroundColor: theme.cardTheme.color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Category",
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 16.h),
            ...createVm.categories.map((category) {
              return ListTile(
                leading: Icon(category.icon, color: AppColors.primary),
                title: Text(category.name, style: theme.textTheme.bodyLarge),
                subtitle: Text("${category.taskCount} Tasks"),
                onTap: () {
                  addVm.setCategory(category.name);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      );
    },
  );
}
