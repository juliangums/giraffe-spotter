import 'package:firebase_core/firebase_core.dart';

class FirebaseInit {


  onInit() {
    try {
      Firebase.initializeApp(
        name: 'giraffe-spotter',
        options: FirebaseOptions(
          apiKey: 'AIzaSyAnX10VazrXJpqRgnCJDRBLSrCq_pFGEwE',
          appId: '1:568065724442:ios:124ac9910a5bbdfd1701a3',
          messagingSenderId: '568065724442',
          projectId: 'giraffespotter-546fc',
        ),
      );
    } on FirebaseException catch (e) {}
    catch (e) {}
  }
}