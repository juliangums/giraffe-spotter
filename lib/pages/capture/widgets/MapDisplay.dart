import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationState.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/MapSearchBloc.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/MapSearchEvent.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/MapSearchState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/delete_account/widgets/DeleteIcon.dart';
import 'package:giraffe_spotter/widgets/Debouncer.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapDisplay extends StatelessWidget {

  final double? latitude;
  final double? longitude;
  final String? place;

  MapDisplay({this.latitude, this.longitude, this.place});

  MapboxMapController? mapController;

  void initController(BuildContext context) {
    mapController!.addListener(() {
      print('change detected ${mapController!.isCameraMoving}');
      if (mapController!.isCameraMoving == false) {
        markerGeoPosition(context);
        context.read<MapSearchBloc>().emit(MapSearchState.idle());
      }else{
        context.read<MapSearchBloc>().emit(MapSearchState.loading());
        controllerText.text = '...';
      }
    });
  }



  void markerGeoPosition(BuildContext context) async {
    LatLng markerLatLng = await mapController!.toLatLng(Point(195.0, 442.6666564941406));
    context.read<LocationCubit>().markerPosition( markerLatLng.latitude, markerLatLng.longitude );
  }

  final TextEditingController controllerText = new TextEditingController();

  bool up = false;

  bool switched = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final _debouncer = Debouncer(milliseconds: 100);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                child: BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state)  {
                    if (state is PlaceState) {
                      controllerText.text = state.place!.name;
                      final coordinates = state.place!.geometry;
                      mapController?..animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(coordinates!.location.lat,
                                  coordinates.location.lng),
                              zoom: 8,
                            ),
                          ),
                        );
                    }
                    if (state is MarkerPosition) {
                      if (state.placemark == null) {
                        controllerText.text = 'Search not found.';
                      }
                      controllerText.text = state.placemark!.name.toString() + " " + state.placemark!.country.toString();
                    }
                  },
                  builder: (context, __) =>
                   Stack(
                    children: [
                      //map image container
                      Container(
                        child:  MapboxMap(
                          accessToken: Constants.mapBoxToken,
                          styleString: context.read<LocationCubit>().switched == true ?
                          'mapbox://styles/mapbox/satellite-streets-v11'
                              : 'mapbox://styles/mapbox/streets-v11',
                          initialCameraPosition: CameraPosition(
                            zoom: 10,
                            target: LatLng(
                                latitude != 0.0 ? latitude! : 8.7832, longitude != 0.0 ? longitude! : 34.5085
                            ),
                          ),
                          onMapCreated: (controller) async {
                            if(place != null && place!.isNotEmpty) {
                              controllerText.text = place!;
                              context.read<MapSearchBloc>().add(Resettings());
                            }
                            mapController = controller;
                            final result = await _determinePosition();
                            mapController
                              ?..animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                        latitude != 0.0 ? latitude! : result.latitude, longitude != 0.0 ? longitude! : result.longitude
                                    ),
                                    zoom: 10,
                                  ),
                                ),
                              );
                            initController(context);
                          },
                          onMapClick:(x,y)=> initController(context),
                          trackCameraPosition: true,
                          zoomGesturesEnabled: true,
                        ),
                        decoration: new BoxDecoration(
                          color: Palette.containerShade,
                          borderRadius: new BorderRadius.only(
                            topRight: const Radius.circular(10.0),
                            topLeft: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.12,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: width * 0.9),
                          margin: EdgeInsets.only(left: width * 0.05),
                          child: BlocBuilder<MapSearchBloc, MapSearchState>(
                              builder: (context, _) => Column(
                                    children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Palette.primaryColor,
                                          borderRadius: new BorderRadius.only(
                                            topRight: const Radius.circular(10.0),
                                            topLeft: const Radius.circular(10.0),
                                            bottomLeft: const Radius.circular(10.0),
                                            bottomRight: const Radius.circular(10.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 2.0,
                                              offset: Offset(1.0, 1.0), // shadow direction: bottom right
                                            )
                                          ],
                                        ),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: TextFormField(
                                                cursorColor: Palette.searchColor,
                                                controller: controllerText,
                                                enableSuggestions: true,
                                                decoration: InputDecoration(
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder:
                                                    InputBorder.none,
                                                    hintText: 'Search Location',
                                                    border: InputBorder.none,
                                                    hintStyle: Styles.searchHint,
                                                    prefixIcon: GestureDetector(
                                                        onTap: () =>
                                                            locator!<AppRoute>()
                                                                .back(),
                                                        child: Transform.translate(
                                                            offset: Offset(6.5, 0),
                                                            child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios, color: Colors.black))),
                                                    suffixIcon: GestureDetector(
                                                        onTap: () => context.read<MapSearchBloc>()
                                                            .add(GetPlaces(
                                                            controllerText.text.trim())),
                                                        child: Container(child: Icon(Icons.search,color: Colors.black,)))),
                                                onChanged: (value) {
                                                  _debouncer.run(() => context
                                                      .read<MapSearchBloc>()
                                                      .add(GetPlaces(value)));
                                                }),
                                          ),
                                          Visibility(
                                              visible:
                                              _ == MapSearchState.idle()
                                                  ? false
                                                  : true,
                                              child: _.maybeWhen(
                                                  getPlacesDone:
                                                      (List<PlacesSearchResult>
                                                  data) =>
                                                  data.isNotEmpty
                                                      ? DisplayPlaces(
                                                      options: data)
                                                      : Container(),
                                                  loading: () => Loader(),
                                                  orElse: () => Container())),
                                        ],
                                      )
                                    ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Switch(
                                            value: context.read<LocationCubit>().switched,
                                            onChanged: (value) {
                                              context.read<LocationCubit>().mapChange(value);
                                            },
                                            activeColor: Colors.white,
                                            inactiveThumbColor: Colors.lightGreenAccent,
                                            activeTrackColor: Colors.grey,
                                            inactiveTrackColor: Colors.green,
                                          ),
                                        ],
                                      )
                                    ],
                             )
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.1,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          constraints: BoxConstraints(maxWidth: width),
                          child: BlocBuilder<LocationCubit, LocationState>(
                            builder: (context, state) {
                              if (state is InitialState) {
                                return Container();
                              } else {
                                return LargeButton(
                                  title: 'Set As Location',
                                  onTap: () => locator!<AppRoute>().back(),
                                  widthSize: 4.0,
                                  heightSize: 52,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                            padding: EdgeInsets.all(10.0),
                            duration: Duration(milliseconds: 25),
                            // Animation speed
                            transform: Transform.translate(
                              offset: Offset(
                                  0,
                                  up == true
                                      ? -20
                                      : 0), // Change -100 for the y offset
                            ).transform,
                            child: AnimatedIconContent(deletePage: false)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Loading indicator
class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        elevation: 0.0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 0.01,
          child: LinearProgressIndicator(
            color: Palette.accentColor,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

//Displays List of places searched
class DisplayPlaces extends StatelessWidget {
  DisplayPlaces({required this.options});

  final Iterable<PlacesSearchResult> options;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.06),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final option = options.elementAt(index);
                final name = option.name;
                final address = option.formattedAddress;
                return GestureDetector(
                  onTap: () {
                    context.read<LocationCubit>().changeCameraPosition(option);
                    context.read<MapSearchBloc>().add(Resettings());
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: RichText(
                          text: TextSpan(
                            text: '$name - ',
                            style: Styles.mapSearchText.copyWith(
                                fontFamily: 'Poppins-SemiBold',
                                color: Palette.primaryTextColor),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '$address',
                                  style: Styles.mapSearchText),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  return await Geolocator.getCurrentPosition();
}
