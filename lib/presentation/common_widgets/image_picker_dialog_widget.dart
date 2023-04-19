import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_text_styles.dart';
import 'package:todo_list/presentation/common_widgets/primary_button.dart';

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({
    Key? key,
    this.galleryPick,
    this.cameraPick,
  }) : super(key: key);
  final Function()? galleryPick;
  final Function()? cameraPick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Container contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Select Action',
            style: AppTextStyles.grey700Medium20Text,
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            title: 'Open Gallery',
            onPressed: () {
              galleryPick!();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 10),
          PrimaryButton(
            title: 'Open Camera',
            onPressed: () {
              cameraPick!();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
