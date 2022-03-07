import 'package:flutter/material.dart';
import '../utils/RichTextUtils.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/TimerUtils.dart';

signUpTest(WidgetTester tester) async{

  final Finder fullName = find.byKey(Key('fullName'));
  final Finder email =  find.byKey(Key('email'));
  final Finder password = find.byKey(Key('password'));
  final Finder show = find.byKey(Key('show'));
  final Finder largeDeprecated = find.byKey(Key('largeDeprecated'));
  final Finder signIn = find.byKey(Key('signIn'));

  await tester.pumpAndSettle(Duration(seconds:2 ));

  await richTextUtils('Sign Up',tester);

  await timerUtils(tester);

  await tester.tap(fullName);

  await timerUtils(tester);

  await tester.enterText(fullName, 'Synt.ax Spotter');

  await timerUtils(tester);

  await tester.tap(email);

  await timerUtils(tester);

  await tester.enterText(email, 'Synt.ax@gmail.com');

  await timerUtils(tester);

  await tester.tap(password);

  await timerUtils(tester);

  await tester.enterText(password, 'Synt.ax');

  await timerUtils(tester);

  await tester.tap(show);

  await timerUtils(tester);

  await tester.tap(largeDeprecated);

  await timerUtils(tester);

  await tester.tap(signIn);

  await timerUtils(tester);
}