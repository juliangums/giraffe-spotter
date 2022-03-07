import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../utils/TimerUtils.dart';

editProfileTest(WidgetTester tester)async{


  final Finder editProfile = find.byKey(Key('editProfile'));
  final Finder backButton = find.byKey(Key('backButton'));
  final Finder fullName = find.byKey(Key('fullName'));
  final Finder email = find.byKey(Key('email'));
  final Finder password = find.byKey(Key('password'));
  final Finder save = find.byKey(Key('largeDeprecated'));


  await timerUtils(tester);
  await tester.tap(editProfile);
  await timerUtils(tester);

  await tester.tap(fullName);

  await timerUtils(tester);
  await tester.enterText(fullName, 'Synt.ax Name');

  await timerUtils(tester);
  await tester.tap(email);

  await timerUtils(tester);
  await tester.enterText(email, 'Synt.ax@gmail.com');

  await timerUtils(tester);
  await tester.tap(password);

  await timerUtils(tester);
  await tester.enterText(password,'Synt.asx');

  await timerUtils(tester);
  await tester.tap(save);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);
}