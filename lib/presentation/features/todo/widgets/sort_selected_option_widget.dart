import 'package:flutter/material.dart';

class SortSelectedOptionWidget extends StatelessWidget {
  const SortSelectedOptionWidget(this._name, {super.key});

  final String _name;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          _name,
        ),
      ),
    );
  }
}
