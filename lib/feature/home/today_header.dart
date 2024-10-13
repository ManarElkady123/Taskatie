
// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskatie/core/functions/navigation.dart';
import 'package:taskatie/core/utils/text_style.dart';
import 'package:taskatie/core/widgets/custom_bottom.dart';
import 'package:taskatie/feature/add_task/add_task.dart';

class TodayHeader extends StatefulWidget {
  const TodayHeader({
    super.key,
  });

  @override
  State<TodayHeader> createState() => _TodayHeaderState();
}

class _TodayHeaderState extends State<TodayHeader> {
  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Column(
          children: [
            
            Text(
              //'Hello ${AppLocalStorage.getCacheData('name')}',
               //'October 30,2024',
               DateFormat.yMMMd().format(DateTime.now()) ,
                
              style: getTitleTextStyle(context),
              
            ),
            Gap(5),
            Text(
              'Today',
              style:getHeadingTextStyle(context,fontSize: 20)),
            
          ],
        ),
        Spacer(),
        CustomButton(text: '+ Add Task', onPressed: (){
          pushTo(context, AddTask());
        } , width: 127, height: 40,)
       
      ],
    );
  }
}
