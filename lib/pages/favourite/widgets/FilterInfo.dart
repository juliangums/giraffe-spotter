import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterCubit.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterState.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FilterGiraffesCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FliterGiraffesState.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/favourite/widgets/AgeSlider.dart';
import 'package:giraffe_spotter/pages/favourite/widgets/DropData.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';

class FilterInfo extends StatelessWidget {
  FilterState? fState;
  FilterInfo({this.fState});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
        child: Wrap (
          runSpacing: 20,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter by',
                  style: Styles.filterBy,
                ),
                GestureDetector(
                  onTap: () => context.read<FilterGiraffesCubit>().returnDefault(),
                  child: Text(
                    'Clear',
                    style: Styles.filterClear,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Location',
                  style: Styles.filterData,
                ),
                DropData(
                  giraffe: false,
                  fState: fState,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Age', style: Styles.filterData),
                    BlocBuilder<FilterGiraffesCubit, FilterGiraffesState>(
                      builder: (context, state) {
                        return Text(state.ageStart.toInt().toString() + "-" + state.ageEnd.toInt().toString(), style: Styles.rangeNumber);
                      },
                    )
                  ],
                ),
                AgeSlider(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: Styles.filterData,
                ),
                BlocBuilder<FilterGiraffesCubit, FilterGiraffesState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Theme(
                                data: Theme.of(context).copyWith(unselectedWidgetColor: state.maleStatus ? Palette.accentColor : null),
                                child: Checkbox(
                                  value: state.maleStatus,
                                  activeColor: Colors.transparent,
                                  checkColor: state.maleStatus ? Palette.accentColor : null,
                                  onChanged: (value) {
                                    context.read<FilterGiraffesCubit>().onMaleChanged(!state.maleStatus);
                                  },
                                )),
                            Transform.translate(offset: Offset(-10, 0), child: Text('Male', style: Styles.radioText))
                          ],
                        ),
                        // SizedBox(width: 36),
                        Row(
                          children: [
                            Theme(
                                data: Theme.of(context).copyWith(unselectedWidgetColor: state.femaleStatus ? Palette.accentColor : null),
                                child: Checkbox(
                                  value: state.femaleStatus,
                                  activeColor: Colors.transparent,
                                  checkColor: state.femaleStatus ? Palette.accentColor : null,
                                  onChanged: (value) {
                                    context.read<FilterGiraffesCubit>().onFemaleChanged(!state.femaleStatus);
                                  },
                                )),
                            Transform.translate(
                                offset: Offset(-10, 0),
                                child: Text(
                                  'Female',
                                  style: Styles.radioText,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                                data: Theme.of(context).copyWith(unselectedWidgetColor: state.unknownStatus ? Palette.accentColor : null),
                                child: Checkbox(
                                  value: state.unknownStatus,
                                  activeColor: Colors.transparent,
                                  checkColor: state.unknownStatus ? Palette.accentColor : null,
                                  onChanged: (value) {
                                    context.read<FilterGiraffesCubit>().onUnknownChanged(!state.unknownStatus);
                                  },
                                )),
                            Transform.translate(
                                offset: Offset(-10, 0),
                                child: Text(
                                  'Unknown',
                                  style: Styles.radioText,
                                ))
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Species',
                    style: Styles.filterData,
                  ),
                ),
                Container(child: DropData(giraffe: true))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocConsumer<FilterGiraffesCubit, FilterGiraffesState>(
                    listener: listener,
                    builder: (context, state) {
                      return ConstrainedBox(
                        constraints: BoxConstraints.expand(
                          height: 52,
                          width: MediaQuery.of(context).size.width / 2.4,
                        ),
                        child: LargeButtonReplacement(
                          title: 'Apply Filter',
                          onTap: () => context.read<FilterGiraffesCubit>().filterGiraffes(),
                          loading: state.status.isSubmissionInProgress ? true : false,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.5, top: 4.5),
                    child: TextButton(
                      onPressed: () => locator!<AppRoute>().back(),
                      child: Text(
                        'cancel',
                        style: Styles.onBoardSkip,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }

  void listener(BuildContext context, FilterGiraffesState state) {
    if (state.status == FormzStatus.submissionSuccess) {
      locator!<AppRoute>().back(params: state.filteredGiraffes);
      context.read<GiraffeProfileCubit>().setFilterData(state.filteredGiraffes);
    }
    if (state.status == FormzStatus.submissionInProgress) {}
    if (state.status == FormzStatus.submissionFailure) {}
  }
}
