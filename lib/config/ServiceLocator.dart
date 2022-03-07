import 'package:get_it/get_it.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';

import 'AppRoute.dart';

GetIt? locator;

class ServiceLocator {
  static GetIt? getInstance() {
    if (locator == null) {
      locator = GetIt.instance;
      setupLocator();
    }
    return locator;
  }

  static setupLocator() {
    final baseUrl = 'https://app.giraffespotter.synt.ax/api';
    locator!.registerLazySingleton(() => AppRoute());
    locator!.registerLazySingleton(() => NetworkClient(baseUrl));
  }
}
