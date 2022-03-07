import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/TimerUtils.dart';

loginRequirementsTest(WidgetTester tester) async {

    final Finder  email = find.byKey(Key('email'));
    final Finder  password = find.byKey(Key('password'));
    final Finder largeButton = find.byKey(Key('largeButton'));
    final Finder show = find.byKey(Key('show'));

  //login
  await timerUtils(tester);

  await tester.tap(email);

  await timerUtils(tester);

  await tester.enterText(email, 'Synt.ax@gmail.com');

  await timerUtils(tester);

  await tester.tap(password);

  await timerUtils(tester);

  await tester.tap(show);

  await timerUtils(tester);

  await tester.tap(largeButton);

  await timerUtils(tester);
}