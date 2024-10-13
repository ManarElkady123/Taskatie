// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/functions/navigation.dart';
import 'package:taskatie/core/model/task_model.dart';
import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:taskatie/core/widgets/custom_bottom.dart';
import 'package:taskatie/feature/home/home_view.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var titleController = TextEditingController();
  var noteController = TextEditingController();

  int SelectedColor = 0;
  String date = DateFormat.yMd().format(DateTime.now());
  String Starttime = DateFormat('hh:mm a').format(DateTime.now());
  String Endtime =
      DateFormat('hh:mm a').format(DateTime.now().add(Duration(hours: 1)));
    var keyform = GlobalKey<FormState>();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: keyform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: getTitleTextStyle(context,),
                ),
                Gap(10),
                TextFormField(
                  style: getTitleTextStyle(context,fontSize: 15 , fontWeight: FontWeight.normal),
                  validator: (value) {
                    if(value == null || value.isEmpty)
                    {
                      return 'Enter Title' ;
                    }
                    else{
                      return null ;
                    }
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title here',
                    hintStyle: getSmallTextStyle(context,
                        15, FontWeight.normal, AppColors.greyColor),
                  ),
                ),
                Divider(),
                Gap(10),
                Text(
                  'Note',
                  style: getTitleTextStyle(context),
                ),
                Gap(10),
                TextFormField(
                  style: getTitleTextStyle(context,fontSize: 15 , fontWeight: FontWeight.normal),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Enter notes' ;
                    }
                    else{
                      return null ;
                    }
                  },
                  controller: noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter Note here',
                    hintStyle: getSmallTextStyle(context,
                        15, FontWeight.normal, AppColors.greyColor),
                  ),
                ),
                Divider(),
                Gap(10),
                Text(
                  'Date',
                  style: getTitleTextStyle(context),
                ),
                Gap(10),
                TextFormField(
                  style: getTitleTextStyle(context, fontSize: 15 , fontWeight: FontWeight.normal),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          date = DateFormat.yMd().format(value);
                        });
                      }
                    });
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: date,
                      hintStyle: getSmallTextStyle(context,
                          15, FontWeight.normal, AppColors.greyColor),
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.greyColor,
                      )),
                ),
                Divider(),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Start Time',
                            style: getTitleTextStyle(context),
                          ),
                          Gap(10),
                          TextFormField(
                            style: getTitleTextStyle(context,fontSize: 15 , fontWeight: FontWeight.normal),
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    Starttime = value.format(context);
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                                hintText: Starttime,
                                hintStyle: getSmallTextStyle(context,
                                    15, FontWeight.normal, AppColors.greyColor),
                                suffixIcon: Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.greyColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'End Time',
                            style: getTitleTextStyle(context),
                          ),
                          Gap(10),
                          TextFormField(
                            style: getTitleTextStyle(context,fontSize: 15 , fontWeight: FontWeight.normal),
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    Endtime = value.format(context);
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                                hintText: Endtime,
                                hintStyle: getSmallTextStyle(context,
                                    15, FontWeight.normal, AppColors.greyColor),
                                suffixIcon: Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.greyColor,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Gap(10),
                Text(
                  'Color',
                  style: getTitleTextStyle(context),
                ),
                // Gap(10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          SelectedColor = 0;
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.blueColor,
                        child: (SelectedColor == 0)
                            ? Icon(
                                Icons.check,
                                color: AppColors.whiteColor,
                              )
                            : null,
                      ),
                    ),
                    Gap(10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          SelectedColor = 1;
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.redColor,
                        child: (SelectedColor == 1)
                            ? Icon(
                                Icons.check,
                                color: AppColors.whiteColor,
                              )
                            : null,
                      ),
                    ),
                    Gap(10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          SelectedColor = 2;
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.orangeColor,
                        child: (SelectedColor == 2)
                            ? Icon(
                                Icons.check,
                                color: AppColors.whiteColor,
                              )
                            : null,
                      ),
                    ),
                    Spacer(),
                    CustomButton(
                      width: 128,
                      height: 40,
                      text: 'create task',
                      onPressed: () {
                        if(keyform.currentState!.validate()){
                          String id = DateTime.now().toIso8601String();
                        AppLocalStorage.cacheTaskData(
                            id,
                            TaskModel(
                              id: id,
                              title: titleController.text,
                              note: noteController.text,
                              date: date ,
                              startTime: Starttime,
                              endTime: Endtime,
                              color: SelectedColor,
                              isCompleted: false,
                            ));
                            pushWithReplacement(context, HomeView());
                        }
                        
                        
                      },
                      
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
