

// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/functions/navigation.dart';
import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:taskatie/feature/home/home_view.dart';
import 'package:taskatie/feature/upload/upload_view.dart';

class Splash extends StatefulWidget {
   Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    
    super.initState();
                   // اول ما هنفتح هتكون ال اب لود ده ب نال فمينفعش نال تتخزن في بولين 
                   // عشان كده حطينا ال فولس عشان لو نال هنعوضها ب فولس و كده هيبقي تمام
    bool isUploaded = AppLocalStorage.getCacheData('isUploaded') ?? false;
    Future.delayed(Duration(seconds: 3), (){
      pushWithReplacement(context,(isUploaded)? HomeView() : UploadView());
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // Future.delayed(Duration),
           Lottie.asset('assets/images/logo.json'),
           Text('Taskati', style: getTitleTextStyle(context)),
          // SizedBox(height: 25,),
          Gap(25),
           Text('its time to get organized' , style: getSmallTextStyle(context,20, FontWeight.normal, AppColors.greyColor)),
        
          ],
        ),
      ),
    );
  }
}