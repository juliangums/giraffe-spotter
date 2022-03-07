import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/TimerUtils.dart';

onBoardSliderTest(WidgetTester tester) async{

  final Finder pageContainer =  find.byKey(Key('ImageContainer'));

  //front drag ...

  await timerUtils(tester);

  await tester.drag(pageContainer, Offset(-400,0),warnIfMissed: false,);

  await timerUtils(tester);

  await tester.drag(pageContainer, Offset(-400, 0),warnIfMissed: false);

  await timerUtils(tester);

  await tester.drag(pageContainer, Offset(-400,0),warnIfMissed: false);

  await timerUtils(tester);

  //BackDrag ...

  await tester.drag(pageContainer,Offset(400,0),warnIfMissed: false);

  await timerUtils(tester);

  await tester.drag(pageContainer, Offset(400,0),warnIfMissed: false);

  await timerUtils(tester);

  await tester.drag(pageContainer,Offset(400,0),warnIfMissed: false);

}