import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/TimerUtils.dart';

onBoardButtonTest(WidgetTester tester) async{

  final Finder skipButton = find.byKey(Key('skip'));
  final Finder nextButton = find.byKey(Key('Next'));
  final Finder pageContainer =  find.byKey(Key('ImageContainer'));
  final Finder largeButton = find.byKey(Key('largeButton'));

  await timerUtils(tester);

  await tester.tap(nextButton);

  await timerUtils(tester);

  await tester.tap(nextButton);

  await timerUtils(tester);

  //Nav back to Page One screen

  await tester.drag(pageContainer,Offset(400,0),warnIfMissed: false);

  await timerUtils(tester);

  await tester.drag(pageContainer, Offset(400,0),warnIfMissed: false);

  await timerUtils(tester);

  await tester.drag(pageContainer,Offset(400,0),warnIfMissed: false);

  await timerUtils(tester);

  await tester.tap(skipButton,warnIfMissed: false);

  await timerUtils(tester);

  //if error occurs just restart the integration test ...
  await tester.tap(largeButton);

  await timerUtils(tester);
}