import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/color.dart';
import 'date_selector/date_selector_viewmodel.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final vm = Provider.of<DateSelectorViewModel>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    // ✅ Move initialization check here safely
    if (vm.selectedDate == null) {
      vm.initializeSelectedDate(screenWidth);
    }
  }

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
                        onTap: () => vm.selectDate(date, screenWidth),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 3.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : theme.cardTheme.color?.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : AppColors.primary.withOpacity(0.2),
                              width: 1.4,
                            ),
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color:
                                AppColors.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                            ]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
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
                              SizedBox(height: 2.h),
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
