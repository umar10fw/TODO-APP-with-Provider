import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/view/screen/create_task/view_model/create_task_viewmodel.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/utils/responsive.dart';
import '../widget/date_selector.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final theme = Theme.of(context);
    final vm = Provider.of<CreateTaskViewModel>(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Text(
                  "Select Category",
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Choose Activity",
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: 15.h),
              ...vm.categories.map((category) {
                return GestureDetector(
                  onTap: () => vm.selectCategory(context, category),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Icon(category.icon,
                            color: AppColors.primary, size: 28.sp),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onBackground,
                                ),
                              ),
                              Text(
                                "${category.taskCount} Tasks",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right,
                            color: theme.iconTheme.color, size: 26.sp),
                      ],
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 40.h),

            ],
          ),
        ),
      ),
    );
  }
}
