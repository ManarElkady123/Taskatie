

import 'package:flutter/material.dart';

Future pushTo(BuildContext context , Widget view) async {
       return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>view));

}

pushWithReplacement(BuildContext context , Widget view){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>view));
}