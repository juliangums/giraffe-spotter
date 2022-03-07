import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/capture/pageCubit/CapturePageCubit.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/pages/capture/pages/PageOne.dart';

class CapturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<CapturePageCubit, int>(
      builder: (context, state) {
        return Container(
          height: height / 1.24,
          child: Column(
            children: [
              Expanded(child: Container(color: Palette.primaryColor, child: PageOne())),
            ],
          ),
        );
      },
    );
  }
}
