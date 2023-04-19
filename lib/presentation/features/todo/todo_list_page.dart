import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/extensions.dart';
import 'package:todo_list/core/router/app_router.dart';
import 'package:todo_list/injection/injector.dart';
import 'package:todo_list/presentation/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_list/presentation/features/todo/widgets/sort_selected_option_widget.dart';
import 'package:todo_list/presentation/features/todo/widgets/sort_drawer_widget.dart';
// import 'package:todo_list/presentation/features/todo/widgets/sort_drawer_widget.dart';
import 'package:todo_list/presentation/features/todo/widgets/todo_list_widget.dart';

@RoutePage()
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textSearchController = TextEditingController();
  final TodoCubit _todoCubit = injector.get<TodoCubit>();
  final AppRouter _appRouter = injector.get<AppRouter>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _todoCubit.getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      bloc: _todoCubit,
      builder: (_, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Todo List'),
            actions: [
              IconButton(
                onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                icon: const Icon(Icons.filter_alt_rounded),
              ),
            ],
          ),
          endDrawer: SortDrawerWidget(
            onCloseDrawer: () => _scaffoldKey.currentState!.closeEndDrawer(),
          ),
          // drawer
          body: Column(
            children: [
              // Search TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _textSearchController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2880ED),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2880ED),
                      ),
                    ),
                    hintText: 'Search by title and description',
                  ),
                  onChanged: _todoCubit.onSearchTodo,
                ),
              ),
              const SizedBox(height: 10),
              // Filter options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text('Filter by: '),
                    const SizedBox(width: 4),
                    SortSelectedOptionWidget(
                      state.sortField.name,
                    ),
                    const SizedBox(width: 8),
                    SortSelectedOptionWidget(
                      state.sortType.getNameByField(state.sortField),
                    ),
                  ],
                ),
              ),
              // Todo List
              Expanded(child: TodoListWidget()),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _appRouter.navigate(TodoDetailRoute()),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
