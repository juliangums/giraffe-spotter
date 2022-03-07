import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../editProfile/EditProfileTest.dart';
import '../utils/TimerUtils.dart';

menuDrawerTest(WidgetTester tester) async {
  final Finder drawer = find.byKey(Key('drawer'));
  final Finder donation = find.byKey(Key('menuItem0'));
  final Finder adoption = find.byKey(Key('menuItem1'));
  final Finder aboutUs = find.byKey(Key('menuItem2'));
  final Finder inviteFriends = find.byKey(Key('menuItem3'));
  final Finder logOut = find.byKey(Key('menuItem4'));
  final Finder deleteAccount = find.byKey(Key('menuItem5'));
  final Finder backButton = find.byKey(Key('backButton'));


  await tester.tap(drawer);
  await timerUtils(tester);
  await timerUtils(tester);

  await editProfileTest(tester);

  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(drawer);
  await timerUtils(tester);
  await timerUtils(tester);
  await tester.tap(find.text('Donation'));
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(drawer);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(find.text('Adoption'));
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(drawer);
  await timerUtils(tester);
  await timerUtils(tester);


  await tester.tap(find.text('About Us'));
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(drawer);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(find.text('Invite friends'));
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(drawer);
  await timerUtils(tester);
  await timerUtils(tester);

  await tester.tap(find.text('Delete Account'));
  await timerUtils(tester);

  //TODO:: add the button function for exit.
  // await tester.tap(confirmDelete);
  // await timerUtils(tester);
  //
  // await tester.tap(midButton);
  // await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);
}