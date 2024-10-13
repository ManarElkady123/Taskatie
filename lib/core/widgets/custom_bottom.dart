// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:taskatie/core/conatants/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.height,
      this.width,
      required this.text,
      required this.onPressed});
  final double? width;
  final double? height;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width?? 45,
        height: height?? 45,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(text)));
  }
}
