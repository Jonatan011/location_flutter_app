import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_palette.dart';

const baseStyle = TextStyle(
  fontFamily: 'Baloo2',
);

// Estilo para títulos principales
final titleStyle = baseStyle.copyWith(
  fontSize: 24.sp,
  fontWeight: FontWeight.w600,
  color: colorPrimary,
);

// Estilo para títulos secundarios
final titleSecondaryStyle = baseStyle.copyWith(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: colorPrimary,
);

//Estilo boton primario
final styleTextButtonPrimary = baseStyle.copyWith(
  fontSize: 14.sp,
  color: white,
  fontWeight: FontWeight.w600,
);

// Estilo para cuerpo de texto
final bodyStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
);

// Estilo para texto de botones
final buttonTextStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: white,
);

// Estilo para resaltados o texto importante
final highlightStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: colorPrimary,
);

// Estilo para resaltados o texto importante
final textNormalStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  fontWeight: FontWeight.normal,
  color: colorPrimary,
);

final sectionTitleStyle = baseStyle.copyWith(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  color: colorPrimary,
);

final inputTextStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  color: Colors.black87,
);

final hintTextStyle = baseStyle.copyWith(
  fontSize: 14.sp,
  color: grey,
);

final detailItemTitleStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
);

final detailItemContentStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  color: Colors.black87,
);

final errorMessageStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  color: red,
);

final emptyMessageStyle = baseStyle.copyWith(
  fontSize: 16.sp,
  color: grey,
);

final locationTitleStyle = baseStyle.copyWith(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);

final splashIconStyle = IconThemeData(
  size: 100.sp,
  color: white,
);

final splashTitleStyle = titleStyle.copyWith(
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
  color: white,
);

// style text BottomNavigationBar
final styleTextNavigation = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  color: black,
);
