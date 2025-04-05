import 'package:location/location.dart';

enum ErrorLocation { serviceNotEnabled, permissionNotGranted }

class GpsHelper {
  static Future<LocationData> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw ErrorLocation.serviceNotEnabled;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw ErrorLocation.permissionNotGranted;
      }
    }
    return await location.getLocation();
  }
}
