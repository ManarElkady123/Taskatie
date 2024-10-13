// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskatie/core/functions/dialogs.dart';
import 'package:taskatie/core/functions/navigation.dart';
import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:gap/gap.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/widgets/custom_bottom.dart';
import 'package:taskatie/feature/home/home_view.dart';

// lib\core\utils\text_style.dart
class UploadView extends StatefulWidget {
  UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  String? path;
  String? name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (path != null && name!.isNotEmpty) {
                  // cash 
                 
                  AppLocalStorage.cacheData('name', name);
                  AppLocalStorage.cacheData('Image', path);
                  AppLocalStorage.cacheData('isUploaded' , true);
                  pushWithReplacement(context, HomeView());


                } else if (path == null && name!.isNotEmpty) {
                  ShowErrorDialog(context, 'Enter photo');
                } else if (path != null && name!.isEmpty) {
                  ShowErrorDialog(context, 'Enter name');
                } else {
                  ShowErrorDialog(context, 'please enter name , and add photo');
                }
              },
              child: Text(
                'Done',
                style: getSmallTextStyle(context ,15, FontWeight.normal, Colors.blue),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 90,
                // backgroundColor: AppColors.blueColor,
                backgroundImage: (path != null && path!.isNotEmpty)
                    ? FileImage(File(path!)) as ImageProvider
                    : AssetImage('assets/images/user_taskati.jpg')
                        as ImageProvider,
              ),
              Gap(20),
              CustomButton(
                text: 'Upload From Camera',
                onPressed: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        path = value.path;
                      });
                    }
                  });
                },
                width: 250,
                height: 45,
              ),
              Gap(15),
              CustomButton(
                text: 'Upload From Gallery',
                onPressed: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        path = value.path;
                      });
                    }
                  });
                },
                width: 250,
                height: 45,
              ),
              Gap(20),
              Divider(),
              Gap(20),
              TextFormField(
                style: getTitleTextStyle(context,fontSize: 15 , fontWeight: FontWeight.normal),
                
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your name',
                  hintStyle: getSmallTextStyle(context,
                    16,  FontWeight.normal,  AppColors.greyColor),
                   
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
