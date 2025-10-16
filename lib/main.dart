import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/view/screen/add_task/view_model/add_task_viewmodel.dart';
import 'package:todo_app/src/view/screen/create_task/view_model/create_task_viewmodel.dart';
import 'package:todo_app/src/view/screen/home/view_model/home_viewmodel.dart';
import 'package:todo_app/src/view/screen/homescreen.dart';
import 'package:todo_app/src/view/screen/widget/date_selector/date_selector_viewmodel.dart';
import 'package:todo_app/src/view/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CreateTaskViewModel()),
        ChangeNotifierProvider(create: (_) => AddTaskViewModel()),
        ChangeNotifierProvider(create: (_) => DateSelectorViewModel()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // base screen (iPhone 12 Pro)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        title: 'Task Planner',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: HomeScreen(),
      ),
    );
  }
}
