import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapFunctions {
  MapboxMapController? mapController;

  void onMapCreated(MapboxMapController? controller) async {
    mapController = controller;
    final result = await acquireCurrentLocation();
    await mapController?.animateCamera(
      CameraUpdate.newLatLng(result!),
    );

    // Add a circle denoting current user location
    await controller?.addCircle(
      CircleOptions(
        circleRadius: 8.0,
        circleColor: '#ff844c',
        circleOpacity: 0.8,
        geometry: result,
        draggable: true,
      ),
    );
  }

  Future<LatLng?> acquireCurrentLocation() async {
    // Initializes the plugin and starts listening for potential platform events
    Location location = new Location();

    // Whether or not the location service is enabled
    bool serviceEnabled;

    // Status of a permission request to use location services
    PermissionStatus permissionGranted;

    // Check if the location service is enabled, and if not, then request it. In
    // case the user refuses to do it, return immediately with a null result
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check for location permissions; similar to the workflow in Android apps,
    // so check whether the permissions is granted, if not, first you need to
    // request it, and then read the result of the request, and only proceed if
    // the permission was granted by the user
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Gets the current location of the user
    final locationData = await location.getLocation();
    return LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
  }
}
