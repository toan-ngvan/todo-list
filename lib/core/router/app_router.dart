import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/presentation/features/home/home_page.dart';
import 'package:todo_list/presentation/features/todo/todo_detail_page.dart';
import 'package:todo_list/presentation/features/todo/todo_list_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: TodoListRoute.page, path: '/'),
        AutoRoute(page: TodoDetailRoute.page),
      ];
}
