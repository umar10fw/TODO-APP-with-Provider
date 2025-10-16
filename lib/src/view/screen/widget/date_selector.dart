import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/color.dart';
import 'date_selector/date_selector_viewmodel.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateSelectorViewModel>(
      builder: (context, vm, _) {
        final theme = Theme.of(context);
        final screenWidth = MediaQuery.of(context).size.width;

        double containerHeight;
        if (screenWidth < 600) {
          containerHeight = 70.h;
        } else if (screenWidth < 1024) {
          containerHeight = 85.h;
        } else {
          containerHeight = 100;
        }

        // ensure current date is selected & centered ONCE after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final today = DateTime.now();
          final todayIndex = vm.daysInMonth.indexWhere(
                (date) =>
            date.day == today.day &&
                date.month == today.month &&
                date.year == today.year,
          );

          // if today exists in list and not selected yet, use the VM method that selects+scrolls
          if (todayIndex != -1 && !vm.isSelected(today)) {
            vm.selectDate(today, screenWidth); // <-- call VM method that does scroll
          }
        });

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                vm.monthName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: SizedBox(
                  height: containerHeight,
                  child: ListView.builder(
                    controller: vm.scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.daysInMonth.length,
                    itemBuilder: (context, index) {
                      final date = vm.daysInMonth[index];
                      final isSelected = vm.isSelected(date);
                      final dayName = DateFormat('EEE').format(date);
                      final dayNumber = DateFormat('d').format(date);

                      return GestureDetector(
                        onTap: () {
                          vm.selectDate(date, screenWidth); // <-- select + scroll
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 4.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 18.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : theme.cardTheme.color?.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayNumber,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontSize: screenWidth < 600
                                      ? 16.sp
                                      : screenWidth < 1024
                                      ? 18.sp
                                      : 20,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textMoreLight,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                              Text(
                                dayName,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: screenWidth < 600
                                      ? 12.sp
                                      : screenWidth < 1024
                                      ? 14.sp
                                      : 16,
                                  color: isSelected
                                      ? Colors.white70
                                      : AppColors.textMoreLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
