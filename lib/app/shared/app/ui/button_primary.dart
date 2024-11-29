import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../design_system/color_palette.dart';
import '../../design_system/styles.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
    this.color,
    super.key,
  });

  final String text;
  final Function() onPressed;
  final bool isLoading;
  final bool disabled;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled || isLoading ? null : onPressed,
      child: Container(
        width: 327.w,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.w),
          color: isLoading || disabled ? grey : color ?? black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      color: white,
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(text, style: styleTextButtonPrimary),
          ],
        ),
      ),
    );
  }
}
