import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// function gives the widget tree time to rebuild ... :)
timerUtils(WidgetTester tester) async{

  await tester.pump();

  // wait for 3 seconds for the data to load or widget to rebuild
  // await tester.pumpAndSettle(Duration(seconds: 3));
  sleep(Duration(seconds: 3));

  await tester.pump();
}