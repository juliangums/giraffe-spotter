import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

import '../utils/TimerUtils.dart';

articleSearchTest(WidgetTester tester)async{


  final Finder searchField = find.byKey(Key('searchField'));
  final Finder gridView = find.byKey(Key('gridView'));
  final Finder articleCard7 = find.byKey(Key('articleCard7'));
  final Finder articleCard0 =  find.byKey(Key('articleCard0'));
  final Finder backButton = find.byKey(Key('backButton'));
  final Finder giraffeView = find.byKey(Key('giraffeviewAll'));

  await timerUtils(tester);
  await tester.tap(giraffeView);
  await timerUtils(tester);

  await tester.tap(searchField);
  await tester.pump();

  await tester.enterText(searchField, 'r');
  await timerUtils(tester);

  await tester.enterText(searchField, 'v');
  await timerUtils(tester);

  await tester.enterText(searchField, '');
  await timerUtils(tester);

  await tester.pump();
}