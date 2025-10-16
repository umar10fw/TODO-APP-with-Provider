import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/color.dart';
import '../../../data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isChecked = task.isCompleted;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color:
        isChecked ? AppColors.primary.withOpacity(0.1) : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isChecked
              ? AppColors.primary.withOpacity(0.5)
              : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "${task.startTime} PM \n${task.endTime} AM",
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isChecked
                        ? AppColors.primary
                        : theme.colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  task.description,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 13.sp,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (_) => onToggle(),
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}
