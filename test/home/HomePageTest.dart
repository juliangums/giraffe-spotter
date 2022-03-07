import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../notifications/notificationsTest.dart';
import '../utils/TimerUtils.dart';

homePageTest(WidgetTester tester)async{

  final Finder searchField = find.byKey(Key('searchField'));
  final Finder giraffeAll = find.byKey(Key('giraffeviewAll'));
  final Finder videoList = find.byKey(Key('videoList'));
  final Finder videoAll = find.byKey(Key('videosviewAll'));
  final Finder giraffeList = find.byKey(Key('giraffeList'));
  final Finder backButton = find.byKey(Key('backButton'));
  final Finder item4 = find.byKey(Key('item4'));
  final Finder notificationButton = find.byKey(Key('notifications'));
  final Finder videoItem = find.byKey(Key('videoItems4'));
  final Finder home = find.byKey(Key('home'));
  final Finder capture = find.byKey(Key('capture'));
  final Finder favourite = find.byKey(Key('favourite'));
  final Finder learn =  find.byKey(Key('learn'));



  await timerUtils(tester);

  //bottom Nav test
  await tester.tap(capture);
  await timerUtils(tester);

  await tester.tap(favourite);
  await timerUtils(tester);

  await tester.tap(learn);
  await timerUtils(tester);

  await tester.tap(home);
  await timerUtils(tester);

  await tester.tap(notificationButton);
  await timerUtils(tester);
  await notificationsTest(tester);

  await timerUtils(tester);

  await tester.tap(searchField);
  await tester.pump();

  await tester.enterText(searchField, 'Synt.ax tests');
  await timerUtils(tester);

  await tester.tap(giraffeAll);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);

  await tester.dragUntilVisible(item4, giraffeList, Offset(-53,0));
  await timerUtils(tester);

  await tester.tap(item4,warnIfMissed: false);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);

  await tester.tap(videoAll);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);


  await tester.dragUntilVisible(videoItem,videoList,Offset(-53, 0));
  await timerUtils(tester);

  //video page starts playing && the test pauses ... more than 3 seconds count ::: :(
  // await tester.tap(videoItem,warnIfMissed: false);
  // await tester.tap(backButton,warnIfMissed: false);
  await timerUtils(tester);
}