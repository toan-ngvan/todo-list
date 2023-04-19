import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/extensions.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    Key? key,
    this.isLoading = false,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight,
      child: Stack(
        children: <Widget>[
          child,
          if (isLoading)
            Container(
              color: Colors.black26,
              child: const Align(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
