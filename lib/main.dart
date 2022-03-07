import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/App.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/Bloc.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/blocs/home/articles/Bloc.dart';
import 'package:giraffe_spotter/blocs/network/CheckConnectionBloc.dart';
import 'package:giraffe_spotter/blocs/pageWrappers/PageWrap.dart';
import 'package:giraffe_spotter/blocs/videos/VideoCubit.dart';
import 'package:giraffe_spotter/blocs/videos/video_search/VideoSearchCubit.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/repositories/FeedRepository.dart';
import 'package:giraffe_spotter/repositories/MapSearchRepository.dart';
import 'package:giraffe_spotter/repositories/ThumbNailRepository.dart';
import 'package:giraffe_spotter/utils/FirebaseInit.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

import 'blocs/authentication/AuthenticationBloc.dart';
import 'blocs/authentication/AuthenticationEvent.dart';
import 'blocs/authentication/forgot_password/ForgotCubit.dart';
import 'blocs/authentication/logout/LogoutCubit.dart';
import 'blocs/capture/date_time/DateTimeCubit.dart';
import 'blocs/home/BottomBarCubit.dart';
import 'blocs/home/articles/ArticleBloc.dart';
import 'blocs/network/CheckConnectionEvent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init packages if need be
  await FirebaseInit().onInit();
  locator = ServiceLocator.getInstance();
  SharedObjects.prefs = await CachedSharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  FeedRepository _feedRepository = FeedRepository();
  MapSearchRepository _mapSearchRepository = MapSearchRepository();
  ThumbNailRepository _thumbNailRepository = ThumbNailRepository();
  AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiRepositoryProvider(
        providers: [RepositoryProvider.value(value: _feedRepository), RepositoryProvider.value(value: _thumbNailRepository)],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PageWrapCubit()),
            BlocProvider(create: (context) => DynamicCubit()),
            BlocProvider(create: (context) => VideoCubit()),
            BlocProvider(create: (context) => VideoSearchCubit()),
            BlocProvider(create: (context) => ImageCaptureCubit(assets: [])),
            BlocProvider(create: (context) => BottomBarCubit()),
            BlocProvider(create: (context) => ArticleBloc(_feedRepository)..add(ArticleEvent.getFeed())),
            BlocProvider(create: (context) => LocationCubit()),
            BlocProvider(create: (context) => DateAndTimeCubit()),
            BlocProvider(create: (context) => CheckNetworkConnectionBloc()..add(ListenConnection())),
            BlocProvider(create: (context) => MapSearchBloc(_mapSearchRepository)..add(MapSearchEvent.getPlaces(''))),
            BlocProvider(create: (context) => LogoutCubit(_authenticationRepository)),
            BlocProvider(create: (context) => AuthenticationBloc(authRepository: _authenticationRepository)),
            BlocProvider(create: (context) => ForgotCubit(_authenticationRepository)),
          ],
          child: BlocProvider(
            create: (context) => AuthenticationBloc(authRepository: _authenticationRepository)..add(AuthenticationStarted()),
            child: App(),
          ),
        ),
      ),
    ),
  );
}
