import 'package:geolocator/geolocator.dart';

  class Location {
   double? latitude;
   double? longitude;

   Future<void> getCurrentLocation() async {
     LocationPermission permission;
     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
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
     print("Before location access");
     try {
       Position position = await Geolocator.getCurrentPosition(
           desiredAccuracy: LocationAccuracy.low);
       latitude = position.latitude;
       longitude = position.longitude;

       print(position);
     } catch(e) {
       print(e);
     }
   }
}