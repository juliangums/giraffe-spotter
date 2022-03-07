import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:formz/formz.dart';

part 'DynamicState.dart';

class DynamicCubit extends Cubit<DynamicState> {
  DynamicCubit() : super(DynamicState());


    void initDynamicLinks() async{

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if(deepLink != null){
      if(deepLink.queryParameters.containsKey('route')){
        emit(state.copyWith( route: deepLink.queryParameters['route'],data: deepLink.queryParameters.containsKey('email') ? deepLink.queryParameters['email'] : deepLink.queryParameters['id'], status: FormzStatus.submissionSuccess, home: false));
      }
    }

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;
        if(deepLink != null){
          if(deepLink.queryParameters.containsKey('route')) {
            emit(state.copyWith( route: deepLink.queryParameters['route'],data: deepLink.queryParameters.containsKey('email') ? deepLink.queryParameters['email'] : deepLink.queryParameters['id'],  status: FormzStatus.submissionSuccess,home: false));
          }
        }
      },
    onError: (OnLinkErrorException e) async {
        emit(state.copyWith( status: FormzStatus.submissionFailure));
      }
    );
  }

    void createDynamicLink(String data, bool forgot) async {
    emit(state.copyWith(status:FormzStatus.submissionInProgress));
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://gspotter.page.link',
        link: forgot == true ? Uri.parse('https://gspotter.page.link.com?route=ResetPassword&email=$data')
            : Uri.parse('https://gspotter.page.link.com?route=GiraffeProfilePage&id=$data'),
        androidParameters: AndroidParameters(packageName: 'ax.synt.giraffe_spotter'),
        iosParameters: IosParameters(bundleId: 'ax.synt.giraffeSpotter')
    );

    final ShortDynamicLink shorty = await parameters.buildShortLink();

    final Uri shortUrl =  shorty.shortUrl;

    emit(state.copyWith(status: FormzStatus.submissionSuccess,shorturl: shortUrl, home: true));

    }

    void stateChanger() async {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
}
