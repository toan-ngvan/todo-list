import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_colors.dart';
import 'package:todo_list/core/extensions/extensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    this.onPressed,
  })  : assert(title is String || title is Widget),
        super(key: key);

  final dynamic title;
  final ValueGetter<void>? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: 48,
      child: Stack(
        children: [
          SizedBox(
            width: context.screenWidth,
            height: 48,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return AppColors.primaryColor;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.white;
                  },
                ),
              ),
              onPressed: onPressed,
              child: title is String ? Text(title) : title,
            ),
          ),
          if (onPressed == null)
            SizedBox(
              width: context.screenWidth,
              height: 48,
              child: ColoredBox(
                color: Colors.white.withOpacity(0.4),
              ),
            )
        ],
      ),
    );
  }
}
