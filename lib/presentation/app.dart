import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_colors.dart';
import 'package:todo_list/core/router/app_router.dart';
import 'package:todo_list/injection/injector.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = injector.get<AppRouter>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: 'Todo',
        theme: ThemeData(
          primarySwatch: AppColors.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
