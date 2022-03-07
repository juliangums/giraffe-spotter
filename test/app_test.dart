import 'package:flutter_test/flutter_test.dart';
import 'package:giraffe_spotter/App.dart';
import 'package:giraffe_spotter/main.dart' as mainApp;
// import 'package:integration_test/integration_test.dart';

import 'articleTest/ArticlePageTest.dart';
import 'articleTest/ArticleSearchTest.dart';
import 'authentication/LoginRequirementsTest.dart';
import 'authentication/SignUpTest.dart';
import 'editProfile/EditProfileTest.dart';
import 'home/HomePageTest.dart';
import 'menu/MenuDrawer_Tests.dart';
import 'onBoardTest/OnBoardButton_Test.dart';
import 'onBoardTest/OnBoardSlider_Test.dart';

void main(){

  // final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized() as IntegrationTestWidgetsFlutterBinding;

  // binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('OnBoard Page Test',() {

    // init the providers before App is called ...
    setUp((){mainApp.main();});

    testWidgets('', (WidgetTester tester)async{

       await tester.pumpWidget(App());

       //OnBoard test ...
       // await onBoardSliderTest(tester);

       await onBoardButtonTest(tester);

       //SignUp test ...
       await signUpTest(tester);

       await loginRequirementsTest(tester);

       //home test ...
       await homePageTest(tester);

       //menu test ...
       await menuDrawerTest(tester);

       //TODO: test after merging ...
       //article test ...
       await articleSearchTest(tester);

       await articlePageTest(tester);

    });
  });

}
