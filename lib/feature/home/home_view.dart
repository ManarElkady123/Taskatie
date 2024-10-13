// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last



import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/model/task_model.dart';
import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:taskatie/feature/home/today_header.dart';
import 'package:taskatie/feature/home/widgets/home_header.dart';
import 'package:taskatie/feature/home/widgets/task_item.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String SelectedDate = DateFormat.yMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              homeHeader(),
              Gap(20),
              TodayHeader(),
              Gap(20),
              DatePicker(
                DateTime.now().subtract(Duration(days: 3)),
                height: 95,
                width: 70,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.blueColor,
                selectedTextColor: AppColors.whiteColor,
                monthTextStyle: getTitleTextStyle( context ,fontSize: 14, fontWeight: FontWeight.normal),
                dateTextStyle:getTitleTextStyle(context ,fontSize: 14, fontWeight: FontWeight.normal) ,
                dayTextStyle: getTitleTextStyle(context ,fontSize: 14, fontWeight: FontWeight.normal),
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    SelectedDate = DateFormat.yMd().format(date);
                  });
                },
              ),
              Gap(20),
              Expanded(
                child: ValueListenableBuilder<Box<TaskModel>>(
                  valueListenable: AppLocalStorage.tasksBox.listenable(),
                  builder: (context, Box<TaskModel> box, child) {
                    List<TaskModel> tasks = [];
                    if (box.values.isNotEmpty) {
                      for (var task in box.values) {
                        if (task.date == SelectedDate) {
                          tasks.add(task);
                        }
                      }
                      if (tasks.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LottieBuilder.asset('assets/images/empty.json'),
                            Text(
                              'No Tasks',
                              style:  getTitleTextStyle(context ,fontSize: 15 , fontWeight: FontWeight.normal),
                            )
                          ],
                        );
                      }
                    }

                    // var tasks = box.values.toList() ;
                    return ListView.builder(
                      itemCount:
                          tasks.length, //AppLocalStorage.tasksBox.length,

                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var task = tasks[index];

                        return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(Icons.check, color: AppColors.whiteColor,),
                                  Gap(8),
                                  Text('Completed' , style: getSmallTextStyle(context ,15, FontWeight.normal, AppColors.whiteColor),)
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:BorderRadius.circular(15),
                            ),
                            ),
                            secondaryBackground: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.delete,color: AppColors.whiteColor,),
                                    Gap(8),
                                    Text('Deleted' , style: getSmallTextStyle(context ,15, FontWeight.normal, AppColors.whiteColor),)
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadiusDirectional.circular(15),
                              ),
                            ),
                            onDismissed:(direction) {
                              if(direction == DismissDirection.endToStart){
                                // delete 
                                box.delete(task.id);
                              } else {
                                // complete
                                box.put(task.id, 
                                TaskModel(
                                  id: task.id,
                                  title: task.title,
                                  note: task.note,
                                  startTime: task.startTime,
                                  endTime: task.endTime,
                                  color: 3 ,
                                  date: task.date,
                                  isCompleted: true,
                                )

                                );
                              }
                            },
                            child: TaskItemCard(task: task));
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
