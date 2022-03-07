import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

import '../utils/RichTextUtils.dart';
import '../utils/TimerUtils.dart';

articlePageTest(WidgetTester tester) async {

  //TODO: add test module for  dynamic link share ...
  const MethodChannel channel = MethodChannel('plugins.flutter.io/url_launcher');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return SnackBar(content: Text('The open url work...'));
    }));
  });

  final Finder backButton = find.byKey(Key('backButton'));
  final Finder articleCard = find.byKey(Key('articleCard4'));
  final Finder listView = find.byKey(Key('listView'));

  await timerUtils(tester);

  await tester.tap(articleCard,warnIfMissed: false);
  await timerUtils(tester);

  //TODO: Tap on the richtext to open urlLaunch
  // await richTextUtils('Operation Twiga V', tester);
  // await timerUtils(tester);

  await tester.tap(backButton);
  await timerUtils(tester);

}
