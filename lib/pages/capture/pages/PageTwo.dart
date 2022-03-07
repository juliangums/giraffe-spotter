import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/capture/CaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/date_time/DateTimeCubit.dart';
import 'package:giraffe_spotter/blocs/capture/date_time/DateTimeState.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationState.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/Bloc.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/MapSearchBloc.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/capture/pages/UploadPage.dart';
import 'package:giraffe_spotter/pages/capture/widgets/DialogContent.dart';
import 'package:giraffe_spotter/pages/capture/widgets/MapDisplay.dart';
import 'package:giraffe_spotter/widgets/ErrorText.dart';
import 'package:intl/intl.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  _PageTwo createState() => _PageTwo();
}

class _PageTwo extends State<PageTwo> with SingleTickerProviderStateMixin {
  String place = 'Tap to set location';
  double latitude = 0.0;
  double longitude = 0.0;

  //Map dialog
  displayDialog(context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      pageBuilder: (context, anim1, anim2) => DialogContent(),
      barrierColor: Palette.primaryTextColor.withOpacity(0.6),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    );
  }

  //Time dialog
  buildMaterialTimePicker(BuildContext context) async {
    final TimeOfDay? timer = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          child: child ?? SizedBox(),
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Palette.accentColor)),
            colorScheme: ColorScheme.light(primary: Palette.accentColor, onPrimary: Colors.white, onSurface: Palette.dividerColor),
          ),
        );
      },
    );
    if (timer != null) {
      context.read<DateAndTimeCubit>().setTimeOfDay(timer);
    }
  }

  //Date dialog
  buildMaterialDatePicker(BuildContext context) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          child: child ?? SizedBox(),
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Palette.accentColor)),
            colorScheme: ColorScheme.light(primary: Palette.accentColor, onPrimary: Colors.white, onSurface: Palette.dividerColor),
          ),
        );
      },
    );
    if (picker != null && picker != DateTime.now()) {
      context.read<DateAndTimeCubit>().setDateTime(picker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptureCubit, CaptureState>(
      buildWhen: (prev, current) => prev.status != current.status || prev.dateTime != current.dateTime || prev.location != current.location,
      listener: listening,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (state.formErrors != null && state.formErrors!.containsKey('images'))
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: ErrorText(error: (state.formErrors!['images'] as List).first),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Location', style: Styles.titlesCapture),
            ),
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, _) {
                print("Current state is :: $_ ");
                if (_ is PlaceState && _.place != null) {
                  place = _.place!.name;
                  latitude =  _.place!.geometry!.location.lat;
                  longitude =  _.place!.geometry!.location.lng;
                  context.read<CaptureCubit>().locationChanged(_.place!.name, _.place!.geometry!.location.lat, _.place!.geometry!.location.lng);
                } else if (_ is ImageState && place == 'Tap to set location') {
                  place = _.placemarks!.name.toString() + ', ' + _.placemarks!.country.toString();
                  latitude = _.latitude!;
                  longitude = _.longitude!;
                  context.read<CaptureCubit>().locationChanged(place, _.latitude!, _.longitude!);
                }
                if (_ is MarkerPosition) {
                  place = _.placemark!.name.toString() + " " + _.placemark!.country.toString();
                  latitude = _.latitude!;
                  longitude = _.longitude!;
                  context.read<CaptureCubit>().locationChanged(place, _.latitude!, _.longitude!);
                }
                if (_ is InitialState) {
                  place = 'Tap to set location';
                  latitude =  0.0;
                  longitude = 0.0;
                  context.read<CaptureCubit>().locationChanged('', 0.0, 0.0);
                }
                return ListTile(
                  minVerticalPadding: 15,
                  onTap: () {
                    // context.read<LocationCubit>().initialState();
                    context.read<MapSearchBloc>().add(Resettings());
                    locator!<AppRoute>().navigateTo(MapDisplay(latitude: latitude,longitude: longitude,place: place == 'Tap to set location' ? '' : place, ));
                  },
                  minLeadingWidth: 2,
                  dense: true,
                  leading: SvgPicture.asset(Assets.locationSvg),
                  title: Text(
                    place,
                    style: Styles.titlesCapture.copyWith (
                      fontSize: 16,
                      color: place == 'Tap to set location' ? Palette.secondaryTextColor : Palette.primaryTextColor,
                    ),
                  ),
                  subtitle: (state.formErrors != null && state.formErrors!.containsKey('locality'))
                      ? ErrorText(error: (state.formErrors!['locality'] as List).first)
                      : (state.formErrors != null && state.formErrors!.containsKey('country'))
                          ? ErrorText(error: (state.formErrors!['country'] as List).first)
                          : (state.formErrors != null && state.formErrors!.containsKey('longitude'))
                              ? ErrorText(error: (state.formErrors!['longitude'] as List).first)
                              : (state.formErrors != null && state.formErrors!.containsKey('latitude'))
                                  ? ErrorText(error: (state.formErrors!['latitude'] as List).first)
                                  : Container(),
                );
              },
            ),
            Divider(thickness: 1, color: Palette.dividerColor.withOpacity(0.15), indent: 15, endIndent: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Date and Time', style: Styles.titlesCapture),
            ),
            BlocBuilder<DateAndTimeCubit, DateAndTimeState>(
              builder: (context, _) => ListTile(
                minLeadingWidth: 25,
                minVerticalPadding: 15,
                dense: true,
                trailing: SizedBox(width: 10),
                leading: SvgPicture.asset(Assets.calendarSvg),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => buildMaterialDatePicker(context),
                      child: Text(
                        context.read<DateAndTimeCubit>().copyWithTime != null &&
                                context.read<DateAndTimeCubit>().copyWithTime != DateTime.utc(1989, 11, 9)
                            ? DateFormat('MMMM dd, yyyy').format(context.read<DateAndTimeCubit>().copyWithTime!)
                            : 'Select Date',
                        style: Styles.titlesCapture.copyWith(
                          fontSize: 16,
                          color: context.read<DateAndTimeCubit>().copyWithTime == null ||
                                  context.read<DateAndTimeCubit>().copyWithTime == DateTime.utc(1989, 11, 9)
                              ? Palette.secondaryTextColor
                              : Palette.primaryTextColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Assets.timeSvg),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => buildMaterialTimePicker(context),
                          child: Text(
                            context.read<DateAndTimeCubit>().timeOfDays != null
                                ? context.read<DateAndTimeCubit>().formatTime(context.read<DateAndTimeCubit>().timeOfDays)
                                : 'Set time',
                            style: Styles.titlesCapture.copyWith(
                              fontSize: 16,
                              color: context.read<DateAndTimeCubit>().timeOfDays == null
                                  ? Palette.secondaryTextColor
                                  : Palette.primaryTextColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                subtitle: (state.formErrors != null && state.formErrors!.containsKey('date'))
                    ? ErrorText(error: (state.formErrors!['date'] as List).first)
                    : Container(),
              ),
            ),
            Divider(indent: 15, endIndent: 25, thickness: 1, color: Palette.dividerColor.withOpacity(0.15)),
          ],
        );
      },
    );
  }

  void listening(BuildContext context, CaptureState state) {
    if (state.status.isSubmissionSuccess) {
      context.read<ImageCaptureCubit>().clearAll();
      context.read<CaptureCubit>().locationChanged('', 0.0, 0.0);
      context.read<DateAndTimeCubit>().setDateTime(null);
      context.read<DateAndTimeCubit>().setTimeOfDay(null);
      context.read<DateAndTimeCubit>().timeOfDays = null;
      place = 'Set Location';
      context.read<LocationCubit>().changeCameraPosition(null);
      locator!<AppRoute>().navigateAndRemoveUntil(UploadPage());
    }
  }
}
