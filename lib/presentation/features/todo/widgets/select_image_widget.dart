import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_list/presentation/common_widgets/image_picker_dialog_widget.dart';

class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({
    super.key,
    required this.onSelectImage,
    this.imageBytes,
  });

  final Uint8List? imageBytes;
  final Function(ImageSource) onSelectImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onSelectImage(context),
      child: Container(
        height: 150,
        constraints: BoxConstraints(minHeight: 150),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0xFFEFEFEF)),
        ),
        alignment: Alignment.center,
        child: imageBytes == null
            ? const Icon(Icons.camera_alt_outlined)
            : Image.memory(
                imageBytes!,
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  Future<void> _onSelectImage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: ((BuildContext context) {
          return ImagePickerDialog(
            cameraPick: () async {
              await onSelectImage(ImageSource.camera);
            },
            galleryPick: () async {
              await onSelectImage(ImageSource.gallery);
            },
          );
        }));
  }
}
