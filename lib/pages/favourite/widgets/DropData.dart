import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterState.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FilterGiraffesCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FliterGiraffesState.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/DropDownData.dart';

class DropData extends StatelessWidget {
  final bool giraffe;

  DropData({required this.giraffe, this.fState});

  FilterState? fState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterGiraffesCubit, FilterGiraffesState>(
      builder: (context, state) {
        return PopupMenuButton(
          child: Row (
            children: [
              Text( giraffe == true ? DropDownData().listSpecies.where((element) => element.value == state.species).first.name : state.location,
                  style: Styles.filterData
              ),
              SizedBox(width: 10),
              Image.asset(Assets.dropDown)
            ],
          ),
          itemBuilder: (BuildContext context) => giraffe
              ? DropDownData().listSpecies.map((species) {
            return PopupMenuItem<String> (
              child: Text(species.name, style: Styles.filterData),
              value: species.value,
            );
          }).toList()
              : fState!.filterFile != null
              ? fState!.filterFile!.map((e) {
            return PopupMenuItem<String>(
              child: Padding (
                padding: EdgeInsets.only(left: e.entries.first.key == false ? 20 : 0),
                child: Text(e.entries.first.value.name,
                    style: Styles.filterData.copyWith(
                        color: e.entries.first.key == false ? Palette.secondaryTextColor : Palette.primaryTextColor)
                ),
              ),
              value: e.entries.first.value.value,
            );
          }).toList()
              : <String>['Select All'].map<PopupMenuItem<String>>((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(value, style: Styles.filterData),
            );
          }).toList(),
          initialValue: giraffe == true ? DropDownData().listSpecies.where((element) => element.value == state.species).first.name : state.location,
          elevation: 8,
          // icon: Image.asset(Assets.dropDown),
          onSelected: (val) => giraffe
              ? context.read<FilterGiraffesCubit>().onSpeciesChanged(val.toString())
              : context.read<FilterGiraffesCubit>().onLocationChanged(val.toString()),
        );
      },
    );
  }
}
