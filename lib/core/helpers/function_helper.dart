import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_native_image/flutter_native_image.dart';

class FunctionHelper {
  static String imgFileToBase64(File imageBytes) {
    final Uint8List bytes = File(imageBytes.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  static Future<File> compressImage(File file) async {
    File compressedImage = await FlutterNativeImage.compressImage(file.path,
        quality: 20, percentage: 60);

    return compressedImage;
  }
}
