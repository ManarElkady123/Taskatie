// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskatie/core/conatants/colors.dart';
import 'package:taskatie/core/model/task_model.dart';
import 'package:taskatie/core/utils/text_style.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 7, right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: task.color == 0
            ? AppColors.blueColor
            : (task.color == 1 ? AppColors.redColor 
            : task.color == 2 
            ? AppColors.orangeColor
            : Colors.green
             ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? '',
                    style: getBodyTextStyle(context,
                        16, FontWeight.normal, AppColors.whiteColor),
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: AppColors.whiteColor,
                        size: 15,
                      ),
                      Gap(5),
                      Text(
                        '${task.startTime} to ${task.endTime}',
                        style: getSmallTextStyle(context,
                            14, FontWeight.normal, AppColors.whiteColor),
                      ),
                    ],
                  ),
                  Gap(5),
                  Text(
                    task.note ?? '',
                    style: getBodyTextStyle(context,
                        16, FontWeight.normal, AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 45,
              color: AppColors.whiteColor,
            ),
            Gap(5),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                (task.isCompleted ?? false) ? 'Completed' : 'To Do',
                style: getSmallTextStyle(context,
                    12, FontWeight.bold, AppColors.whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
