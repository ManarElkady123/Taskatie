// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/services/local_storage.dart';

TextStyle getTitleTextStyle( context ,
    {double? fontSize, FontWeight? fontWeight, Color? Color}) {
      
  return TextStyle(
    fontSize: fontSize ?? 20,
    color: Color ??  Theme.of(context).colorScheme.onSurface ,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}

TextStyle getBodyTextStyle( context,
    double? fontSize, FontWeight? fontWeight, Color? color) {
      
  return TextStyle(
    fontSize: fontSize ?? 15,
    fontWeight: fontWeight ?? FontWeight.w300,
    color: color ?? Theme.of(context).colorScheme.onSurface ,
  );
}

TextStyle getSmallTextStyle( context ,
    double? fontSize, FontWeight? fontWeight, Color? color) {
      
  return TextStyle(
    fontSize: fontSize ?? 13,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? Theme.of(context).colorScheme.onSurface ,
  );
}

TextStyle getHeadingTextStyle( context ,
    {double? fontSize, FontWeight? fontWeight, Color? Color}) {
       
  return TextStyle(
    fontSize: fontSize ?? 25,
    color: Color ?? Theme.of(context).colorScheme.onSurface ,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}
