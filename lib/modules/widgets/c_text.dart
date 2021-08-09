import 'package:flutter/material.dart';
import 'package:find_same_picture/utils/constants.dart' as c;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final String fontFamily;
  final double? strutHeight;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final VoidCallback? onTap;

  const CText(
    this.text, {
    Key? key,
    this.color,
    this.fontFamily = c.fontNotoSans,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.strutHeight,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeFont = 14;
    if (fontSize == null) {
      sizeFont = 14.sp;
    } else {
      sizeFont = fontSize!;
    }
    StrutStyle? strutStyle;
    if (strutHeight != null) {
      strutStyle = StrutStyle(
        height: strutHeight,
        forceStrutHeight: true,
      );
    }
    Widget textWidget = Text(
      text,
      key: key,
      style: TextStyle(
        inherit: false,
        color: color ?? (Get.isDarkMode ? Colors.white : Colors.black),
        fontSize: sizeFont,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        fontFamily: fontFamily,
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );

    if (onTap != null) {
      textWidget = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: textWidget,
      );
    }
    return textWidget;
  }
}
