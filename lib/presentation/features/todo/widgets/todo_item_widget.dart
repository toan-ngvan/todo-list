import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_text_styles.dart';
import 'package:todo_list/core/extensions/extensions.dart';
import 'package:todo_list/core/router/app_router.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/injection/injector.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget(this._todoEntity, {super.key});

  final TodoEntity _todoEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => injector.get<AppRouter>().navigate(
            TodoDetailRoute(todoEntity: _todoEntity),
          ),
      child: Container(
        width: context.screenWidth,
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(0, 8),
              blurRadius: 32,
              color: const Color(0xFF5E5E5E).withOpacity(0.16),
            )
          ],
        ),
        child: Row(
          children: [
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _todoEntity.title.overflow,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.semiBold16Text,
                    maxLines: 1,
                  ),
                  if (_todoEntity.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      _todoEntity.description.overflow,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.normal13Text,
                      maxLines: 2,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: 'Status: ',
                      style: AppTextStyles.greyMedium13Text,
                      children: [
                        TextSpan(text: _todoEntity.statusEnum.text),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Date: ',
                      style: AppTextStyles.greyMedium13Text,
                      children: [
                        TextSpan(text: _todoEntity.dateString),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Image
            if (_todoEntity.fileDecode != null)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(_todoEntity.fileDecode!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
