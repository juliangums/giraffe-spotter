import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/TimerUtils.dart';

notificationsTest(WidgetTester tester ) async{

  final Finder backButton = find.byKey(Key('backButton'));
  final Finder largeDeprecated = find.byKey(Key('largeDeprecated'));
  final Finder notificationsItem1 = find.byKey(Key('notifications1'));
  final Finder notificationsItem7 = find.byKey(Key('notifications7'));

  await timerUtils(tester);

  // Bug is mostly coz of widget building incomplete ...
  await tester.tap(notificationsItem1);
  await timerUtils(tester);

  await tester.tap(backButton);

  await timerUtils(tester);
  await tester.tap(notificationsItem7);
  await timerUtils(tester);
  await tester.tap(backButton);
  await timerUtils(tester);
  await timerUtils(tester);
  await tester.tap(backButton);

  await timerUtils(tester);
}