// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskatie/core/conatants/colors.dart';

import 'dart:io';

import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:taskatie/core/widgets/custom_bottom.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Profile',
            style: getBodyTextStyle(context ,20, FontWeight.bold, AppColors.whiteColor),
          ),
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.blueColor,
          actions: [
            IconButton(
              onPressed: () {
                bool isDark = AppLocalStorage.getCacheData('isDark') ?? false;
                if (isDark) {
                  AppLocalStorage.cacheData('isDark', false);
                } else {
                  AppLocalStorage.cacheData('isDark', true);
                }
                setState(() {});
              },
              icon: Icon(Icons.light_mode),
            )
          ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AppLocalStorage.getCacheData('Image') !=
                            null
                        ? FileImage(File(AppLocalStorage.getCacheData('Image')))
                            as ImageProvider
                        : AssetImage('assets/images/user taskati.jpg'),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          ShowImageBottomSheet(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).scaffoldBackgroundColor ),
                              // AppColors.whiteColor),
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ))
                ],
              ),
              Gap(30),
              Divider(
                thickness: 1,
                color: AppColors.blueColor,
              ),
              Gap(20),
              Row(
                children: [
                  Text(
                    AppLocalStorage.getCacheData('name'),
                    style: getBodyTextStyle(context ,
                        15, FontWeight.normal, AppColors.blueColor),
                  ),
                  Spacer(),
                  // IconButton(onPressed: (){}, icon: Icon(Icons.edit), color: AppColors.blueColor,) ,
                  IconButton.outlined(
                      onPressed: () {
                        ShowNameBottomSheet(context);
                      },
                      color: AppColors.blueColor,
                      icon: Icon(Icons.edit))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ShowImageBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              // AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Gap(15),
                  CustomButton(
                    width: double.infinity,
                    text: 'Upload from Camera',
                    onPressed: () {
                      pickProfileImage(isCamera: true);
                    },
                  ),
                  Gap(15),
                  CustomButton(
                    width: double.infinity,
                    text: 'Upload from Gallary',
                    onPressed: () {
                      pickProfileImage(isCamera: false);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  ////////////////////
  ShowNameBottomSheet(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    var textcontroller = TextEditingController(
      text: AppLocalStorage.getCacheData('name'),
    );
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor ,
              // AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        height: 3,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Gap(15),
                      TextFormField(
                        style: getTitleTextStyle(context, fontSize: 15 , fontWeight: FontWeight.normal),
                       // style: getTitleTextStyle(fontSize: 15 , fontWeight: FontWeight.normal),
                        controller: textcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Update name';
                          }
                        },
                      ),
                      Gap(15),
                      CustomButton(
                        width: double.infinity,
                        text: 'Update name',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            AppLocalStorage.cacheData(
                                'name', textcontroller.text);
                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  pickProfileImage({bool isCamera = true}) {
    ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        AppLocalStorage.cacheData('image', value.path);
        setState(() {});
      }
    });
    Navigator.pop(context);
  }
}
