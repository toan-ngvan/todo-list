import 'package:flutter/material.dart';

class FontWeightCustom {
  static const normal = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
}

class AppTextStyles {
  // Base
  /// Default TextStyle
  /// size: 15,
  /// fontWeight: FontWeightCustom.normal,
  /// color: Colors.black,
  static const normalText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightCustom.normal,
    color: Colors.black,
  );
  static final normal13Text = normalText.copyWith(
    fontSize: 13,
  );
  static final bold24Text = normalText.copyWith(
    fontSize: 24,
    fontWeight: FontWeightCustom.bold,
  );
  static final semiBold16Text = normalText.copyWith(
    fontSize: 16,
    fontWeight: FontWeightCustom.semiBold,
  );

  // Grey
  static final grey700Medium20Text = normalText.copyWith(
    fontSize: 20,
    fontWeight: FontWeightCustom.medium,
    color: Colors.grey[700],
  );
  static final greyMedium13Text = normalText.copyWith(
    fontSize: 13,
    fontWeight: FontWeightCustom.medium,
    color: Colors.grey,
  );

  // White
  static final whiteMedium20Text = normalText.copyWith(
    fontSize: 20,
    fontWeight: FontWeightCustom.semiBold,
    color: Colors.white,
  );
  static final whiteMediumText = normalText.copyWith(
    color: Colors.white,
    fontWeight: FontWeightCustom.medium,
  );
}
