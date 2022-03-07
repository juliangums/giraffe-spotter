import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FilterGiraffesCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FliterGiraffesState.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class AgeSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterGiraffesCubit, FilterGiraffesState>(
      builder: (context, state) {
        return Transform.translate(
          offset: Offset(-15, 0),
          child: RangeSlider(
            values: RangeValues(state.ageStart.toDouble(), state.ageEnd.toDouble()),
            max: 100,
            min: 1,
            activeColor: Palette.accentColor,
            inactiveColor: Palette.rangeColor,
            onChanged: (RangeValues values) {
              context.read<FilterGiraffesCubit>().onAgeChanged(values.start.toInt(), values.end.toInt());
            },
          ),
        );
      },
    );
  }
}
