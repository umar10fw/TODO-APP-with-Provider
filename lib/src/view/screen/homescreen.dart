import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/view/screen/add_task/add_task_screen.dart';
import 'package:todo_app/src/view/screen/widget/date_selector.dart';
import 'package:todo_app/src/view/screen/widget/task_card.dart';
import '../../core/constant/color.dart';
import 'add_task/view_model/add_task_viewmodel.dart';
import 'create_task/create_task_screen.dart';
import 'create_task/view_model/create_task_viewmodel.dart';
import 'home/view_model/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    final theme = Theme.of(context);

    final overlayStyle = theme.brightness == Brightness.dark
        ? SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: theme.scaffoldBackgroundColor,
    )
        : SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: theme.scaffoldBackgroundColor,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Title
                    Center(
                      child: Text(
                        "Note Task",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // 🔹 Header Card
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.blue.shade50,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                "${vm.tasks.length} Tasks",
                                style: theme.textTheme.headlineMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(
                              backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                              foregroundColor:
                              WidgetStateProperty.all(AppColors.primary),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CreateTaskScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Add New",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // 🔹 Category Selector
                    GestureDetector(
                      onTap: () => _showCategoryBottomSheet(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 14.h),
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
                                Provider.of<AddTaskViewModel>(context)
                                    .selectedCategory ??
                                    "Select Category",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.onBackground,
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
                    SizedBox(height: 10.h),

                    // 🔹 Horizontal Date Selector
                    const DateSelector(),
                    SizedBox(height: 10.h),

                    // 🔹 My Tasks
                    Text(
                      "My Tasks",
                      style: theme.textTheme.headlineMedium!
                          .copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.h),

                    // ✅ Task List with small rounded slide actions
                    SlidableAutoCloseBehavior(
                      closeWhenOpened: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: vm.tasks.length,
                        itemBuilder: (context, index) {
                          final task = vm.tasks[index];
                          return Slidable(
                            key: ValueKey(task.id),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              extentRatio: 0.35, // compact width
                              children: [
                                // Delete
                                SlidableAction(
                                  onPressed: (context) =>
                                      vm.deleteTask(task.id),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.red,
                                  icon: Icons.delete,
                                  borderRadius: BorderRadius.circular(40),
                                  padding: const EdgeInsets.all(2),
                                  spacing: 0,
                                  flex: 1,
                                ),
                                // Edit
                                SlidableAction(
                                  onPressed: (context) =>
                                      vm.updateTask(task.id),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.blue,
                                  icon: Icons.edit,
                                  borderRadius: BorderRadius.circular(40),
                                  padding: const EdgeInsets.all(8),
                                  spacing: 0,
                                ),
                              ],
                            ),
                            child: TaskCard(
                              task: task,
                              onToggle: () => vm.toggleTask(task.id),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: isLandscape ? 40.h : 80.h),
                  ],
                ),
              );
            },
          ),
        ),

        // 🔹 Floating Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddTaskScreen(selectedCategory: ""),
              ),
            );
          },
          child: Icon(Icons.add, size: 28.sp, color: Colors.white),
        ),
      ),
    );
  }
}

// 🔹 Shared Category Bottom Sheet
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
                title: Text(
                  category.name,
                  style: theme.textTheme.bodyLarge,
                ),
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
