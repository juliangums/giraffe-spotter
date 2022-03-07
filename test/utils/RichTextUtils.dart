import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

//handles the richtext ontap calls....
//PARAMS : String ==> the textSpan "TEXT" and  widgetTester ==> tester of the respective test class...
richTextUtils(String rtUtils, WidgetTester tester)async{

  bool findTextAndTap(InlineSpan visitor, String text) {
    if (visitor is TextSpan && visitor.text == text) {
      (visitor.recognizer as TapGestureRecognizer).onTap!();
      return false;
    }
    return true;
  }

  bool tapTextSpan(RichText richText, String text) {
    final isTapped = !richText.text.visitChildren((visitor) => findTextAndTap(visitor, text),);
    return isTapped;
  }

  final theText = find.byWidgetPredicate((widget) => widget is RichText && tapTextSpan(widget, rtUtils));

  //tap call on the screen
  await tester.tap(theText,warnIfMissed: false);

}