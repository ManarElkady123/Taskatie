// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/functions/navigation.dart';
import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:taskatie/feature/profile/profile_view.dart';

class homeHeader extends StatefulWidget {
  const homeHeader({
    super.key,
  });

  @override
  State<homeHeader> createState() => _homeHeaderState();
}

class _homeHeaderState extends State<homeHeader> {
  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Column(
          children: [
            Text(
              'Hello ${AppLocalStorage.getCacheData('name')}',
              style: getTitleTextStyle(context,
                Color: AppColors.blueColor,
              ),
            ),
            Gap(5),
            Text(
              'Have a nice day',
              style: getTitleTextStyle(context ,fontWeight: FontWeight.normal, fontSize: 15),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            pushTo(context, ProfileView()).then((value){
              setState(() {
                
              });
            });
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AppLocalStorage.getCacheData('Image') != null 
            ? FileImage(File(AppLocalStorage.getCacheData('Image'))) as ImageProvider
            : AssetImage('assets/images/user taskati.jpg'),
          ),
        )
      ],
    );
  }
}
