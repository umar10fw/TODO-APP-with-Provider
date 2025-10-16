import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/src/view/screen/add_task/view_model/add_task_viewmodel.dart';
import '../../../core/constant/color.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/utils/responsive.dart';

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
                // IconButton(
                //   onPressed: () => Navigator.pop(context),
                //   icon: Icon(Icons.arrow_back,
                //       color: theme.iconTheme.color, size: 24.sp),
                // ),
                Text(
                  "Create Task",
                  style: theme.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // // Calendar placeholder
            // Container(
            //   height: 280.h,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: AppColors.primary.withOpacity(0.05),
            //     borderRadius: BorderRadius.circular(16.r),
            //   ),
            //   child: const Center(
            //     child: Text("Calendar Placeholder"),
            //   ),
            // ),

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
                focusedDay: DateTime.now(),
                firstDay: DateTime(2020),
                lastDay: DateTime(2100),
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
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) {
                  return isSameDay(day, DateTime.now());
                },
                onDaySelected: (selectedDay, focusedDay) {

                },
              ),
            ),

            SizedBox(height: 20.h),

            // Category Dropdown
            Container(
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
                      selectedCategory,
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

            SizedBox(height: 20.h),

            // Title Field
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
                enabledBorder: OutlineInputBorder(
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

                  // Description Field
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
                enabledBorder: OutlineInputBorder(
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
            // Create Task Button
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
                onPressed: () => vm.createTask(),
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
