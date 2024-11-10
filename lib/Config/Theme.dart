import 'package:flutter/material.dart';

import 'Colors.dart';

var lightTheme = ThemeData(
  useMaterial3: true,

  colorScheme: const ColorScheme.light(
    surface: LBgColor,
    onSurface: LFontcolor,
    primaryContainer: LDivcolor,
    onPrimaryContainer: LFontcolor,
    onSecondary: LLabelcolor,
  )
);
var DarkTheme = ThemeData(
  useMaterial3: true,

colorScheme:const ColorScheme.dark(
surface: DBgColor,
onSurface: DFontcolor,
primaryContainer: DDivcolor,
onPrimaryContainer: DFontcolor,
onSecondary: DLabelcolor,
));