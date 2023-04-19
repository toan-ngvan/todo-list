import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_list/core/constants/app_colors.dart';
import 'package:todo_list/core/constants/app_text_styles.dart';
import 'package:todo_list/core/helpers/function_helper.dart';
import 'package:todo_list/core/router/app_router.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/injection/injector.dart';
import 'package:todo_list/presentation/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_list/presentation/common_widgets/base_page.dart';
import 'package:todo_list/presentation/features/todo/widgets/select_image_widget.dart';

@RoutePage()
class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key, this.todoEntity});
  final TodoEntity? todoEntity;

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _createdDateController = TextEditingController();
  final TodoCubit _todoCubit = injector.get<TodoCubit>();
  final AppRouter _appRouter = injector.get<AppRouter>();
  late TodoEntity _todo;

  @override
  void initState() {
    super.initState();
    _todo = widget.todoEntity ?? TodoEntity.empty();
    _titleController.text = _todo.title;
    _descriptionController.text = _todo.description;
    _createdDateController.text = _todo.dateString;
  }

  String? _validateTitle() {
    if (_titleController.text.isEmpty) {
      return 'Title can not empty';
    }
    if (_titleController.text.length > 100) {
      return 'Title cannot be more than 100 characters';
    }
    return null;
  }

  void _onSetTodo() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_todo == widget.todoEntity) return;
    _todoCubit.setTodo(_todo);
  }

  void _onChangeTitle(String title) {
    setState(() {
      _todo = _todo.copyWith(title: title);
    });
  }

  void _onChangeDes(String description) {
    setState(() {
      _todo = _todo.copyWith(description: description);
    });
  }

  void _onSelectDate(DateRangePickerSelectionChangedArgs selectedDate) {
    final date = selectedDate.value as DateTime;
    setState(() {
      _createdDateController.text = DateFormat('yyyy-MM-dd').format(date);
      _todo = _todo.copyWith(date: date.millisecondsSinceEpoch);
    });
    Navigator.pop(context);
  }

  void _onChangeStatus() {
    setState(() {
      _todo = _todo.copyWith(status: _todo.statusEnum.isCompleted ? 0 : 1);
    });
  }

  void _onSetSuccess() {
    Fluttertoast.showToast(
      msg: 'Success',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green[300],
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _todoCubit.getTodoList();
    _appRouter.pop();
  }

  void _onSetFailed() {
    Fluttertoast.showToast(
      msg: 'Something went wrong',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[300],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      bloc: _todoCubit,
      listenWhen: (previous, current) =>
          previous.setTodoEntity != current.setTodoEntity,
      listener: (context, state) {
        if (state.setTodoEntity != null) {
          if (state.setTodoEntity!.isSuccess) {
            _onSetSuccess();
          }
          if (state.setTodoEntity!.isFailure) {
            _onSetFailed();
          }
        }
      },
      builder: (_, state) {
        return BasePage(
          isLoading: state.setTodoEntity?.isLoading == true,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:
                  Text(widget.todoEntity != null ? 'Todo Detail' : 'New Todo'),
              actions: [
                if (widget.todoEntity == null)
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _onSetTodo();
                      }
                    },
                    child: Text(
                      'Add',
                      style: AppTextStyles.whiteMediumText,
                    ),
                  )
                else
                  TextButton(
                    onPressed: _onSetTodo,
                    child: Text(
                      'Update',
                      style: AppTextStyles.whiteMediumText,
                    ),
                  )
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Title
                    Text('Title', style: AppTextStyles.semiBold16Text),
                    TextFormField(
                      controller: _titleController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: AppTextStyles.normalText,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      validator: (_) => _validateTitle(),
                      onChanged: _onChangeTitle,
                    ),
                    const SizedBox(height: 20),
                    // Description
                    Text('Description', style: AppTextStyles.semiBold16Text),
                    TextFormField(
                      controller: _descriptionController,
                      style: AppTextStyles.normalText,
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      validator: (_) => _validateTitle(),
                      onChanged: _onChangeDes,
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Created Date',
                          style: AppTextStyles.semiBold16Text,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: SizedBox(
                            // width: ,
                            child: TextFormField(
                              controller: _createdDateController,
                              style: AppTextStyles.normalText,
                              readOnly: true,
                              onTap: _openDatePicker,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                suffixIcon: Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Image Picker
                    Text('Image', style: AppTextStyles.semiBold16Text),
                    const SizedBox(height: 8),
                    SelectImageWidget(
                      onSelectImage: _onSelectImage,
                      imageBytes: _todo.fileDecode,
                    ),
                    const SizedBox(height: 30),
                    // Status
                    InkWell(
                      onTap: _onChangeStatus,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _todo.statusEnum.isCompleted,
                              onChanged: (value) => _onChangeStatus(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('Mark as completed'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _openDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 300,
            width: 300,
            child: SfDateRangePicker(
              enablePastDates: false,
              showNavigationArrow: true,
              initialDisplayDate: _todo.dateByDateTime,
              initialSelectedDate: _todo.dateByDateTime,
              headerStyle: const DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                color: AppColors.primaryColor,
              )),
              onSelectionChanged: _onSelectDate,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSelectImage(ImageSource imageSource) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);

      if (image == null) {
        return;
      }
      final File imageTemporary = File(image.path);
      final imageFile = await FunctionHelper.compressImage(imageTemporary);
      setState(() {
        _todo =
            _todo.copyWith(image: FunctionHelper.imgFileToBase64(imageFile));
      });
    } catch (_) {}
  }
}
