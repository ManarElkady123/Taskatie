
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taskatie/core/conatants/colors.dart';

ShowErrorDialog(BuildContext context , String text){
  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.redColor,
                        content: Text(text)));
}