import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../utils/TimerUtils.dart';

pageOneTest(WidgetTester tester)async{

  final Finder largeButton = find.byKey(Key('largeDeprecated'));
  final Finder pageView = find.byKey(Key('pageView'));


  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(largeButton);
  await timerUtils(tester);
  
  
  await tester.dragUntilVisible(pageView, largeButton,Offset(-250,0));








  //test for drag ability



}