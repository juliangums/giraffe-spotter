import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/pages/AppView.dart';

import 'config/Constants.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // smartLookView();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Timer(Duration(milliseconds: 1000), () {
        BlocProvider.of<DynamicCubit>(context).initDynamicLinks();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    Smartlook.stopRecording();
  }

  @override
  Widget build(BuildContext context) {
    return AppView();
  }

  smartLookView() {
    SetupOptions options = (new SetupOptionsBuilder(Constants.SmartLookKey)).build();
    Smartlook.setupAndStartRecording(options);
    Smartlook.enableCrashlytics(true);
    Smartlook.startRecording();
  }
}
