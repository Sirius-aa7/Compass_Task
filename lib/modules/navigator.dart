import 'package:flutter/material.dart';
import 'dart:math';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final TextEditingController _currentLatController = TextEditingController();
  final TextEditingController _currentLonController = TextEditingController();
  final TextEditingController _destLatController = TextEditingController();
  final TextEditingController _destLonController = TextEditingController();
  double _currentLat = 0.0;
  double _currentLon = 0.0;
  double _destinationLat = 0.0;
  double _destinationLon = 0.0;
  double _angle = 0.0;
  double _distance = 0.0;

  @override
  void initState() {
    super.initState();
    _currentLatController.addListener(_updateNavigation);
    _currentLonController.addListener(_updateNavigation);
    _destLatController.addListener(_updateNavigation);
    _destLonController.addListener(_updateNavigation);
  }

  void _updateNavigation() {
    setState(() {
      _currentLat = double.tryParse(_currentLatController.text) ?? 0.0;
      _currentLon = double.tryParse(_currentLonController.text) ?? 0.0;
      _destinationLat = double.tryParse(_destLatController.text) ?? 0.0;
      _destinationLon = double.tryParse(_destLonController.text) ?? 0.0;

      if (_currentLat != 0.0 && _currentLon != 0.0 && _destinationLat != 0.0 && _destinationLon != 0.0) {
        _angle = _calculateAngle(
          _currentLat,
          _currentLon,
          _destinationLat,
          _destinationLon,
        );
        _distance = _calculateDistance(
          _currentLat,
          _currentLon,
          _destinationLat,
          _destinationLon,
        );
      }
    });
  }

  double _calculateAngle(double startLat, double startLon, double endLat, double endLon) {
    double dLon = endLon - startLon;
    double y = sin(dLon) * cos(endLat);
    double x = cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLon);
    double brng = atan2(y, x);
    brng = (brng * 180 / pi + 360) % 360; // Convert to degrees and normalize
    return brng;
  }

  double _calculateDistance(double startLat, double startLon, double endLat, double endLon) {
    const double R = 6371e3; // Radius of Earth in meters
    double phi1 = startLat * pi / 180;
    double phi2 = endLat * pi / 180;
    double deltaPhi = (endLat - startLat) * pi / 180;
    double deltaLambda = (endLon - startLon) * pi / 180;

    double a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = R * c;
    return distance; // Distance in meters
  }

  @override
  void dispose() {
    _currentLatController.dispose();
    _currentLonController.dispose();
    _destLatController.dispose();
    _destLonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _currentLatController,
                    decoration: InputDecoration(labelText: 'Current Latitude'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _currentLonController,
                    decoration: InputDecoration(labelText: 'Current Longitude'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _destLatController,
                    decoration: InputDecoration(labelText: 'Destination Latitude'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _destLonController,
                    decoration: InputDecoration(labelText: 'Destination Longitude'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Spacer(),
            Transform.rotate(
              angle: _angle * pi / 180,
              child: Icon(
                Icons.arrow_upward,
                size: 100,
              ),
            ),
            Text('Angle: ${_angle.toStringAsFixed(2)}°'),
            Text('Distance: ${(_distance / 1000).toStringAsFixed(2)} km'),
            Spacer(),
          ],
      ),
    );
  }
}

// FIRST CODE IS WORKING, NEED TO TEST ON MOBILE
// BELOW CODE NEEDS TO BE TESTED FOR OBTAINING LOCATION
// CURRENTLY WE ARE NOT USING INTERNET FOR NAVIGATION AS IT MIGHT NOT BE AVAILABLE EVERYWHERE
// WE CAN CALL THE _location as follows to obtain the location or else we can keep calculating it cont using geolocatoe pkg

// static Position? _position;
// import 'path/to/gps_demo.dart';
// // In another.dart file
// import 'path/to/gps_demo.dart';
//
// void someFunction() {
//   // Accessing _position
//   if (_GPSDemoState._position != null) {
//     // Do something with _GPSDemoState._position
//     double latitude = _GPSDemoState._position!.latitude;
//     double longitude = _GPSDemoState._position!.longitude;
//     print('Latitude: $latitude, Longitude: $longitude');
//   }
// }

// WE WILL USE INTERNET IN THE BELOW SECTION OR NOT FOR FASTER CALCULATIONS?
//
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'dart:math';
//
// class NavigationPage extends StatefulWidget {
//   @override
//   _NavigationPageState createState() => _NavigationPageState();
// }
//
// class _NavigationPageState extends State<NavigationPage> {
//   final TextEditingController _destLatController = TextEditingController();
//   final TextEditingController _destLonController = TextEditingController();
//   LocationData? _currentLocation;
//   Location _location = Location();
//   double _angle = 0.0;
//   double _distance = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupLocation();
//   }
//
//   void _setupLocation() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//
//     print("tryinh");
//
//     _serviceEnabled = await _location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await _location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       setState(() {
//         _currentLocation = currentLocation;
//         print(currentLocation.toString());
//         _updateNavigation();
//       });
//     });
//     // print(_currentLocation.toString());
//     print('ack');
//   }
//
//   void _updateNavigation() {
//     if (_currentLocation != null) {
//       double destLat = double.tryParse(_destLatController.text) ?? 0.0;
//       double destLon = double.tryParse(_destLonController.text) ?? 0.0;
//
//       _angle = _calculateAngle(
//         _currentLocation!.latitude!,
//         _currentLocation!.longitude!,
//         destLat,
//         destLon,
//       );
//
//       _distance = _calculateDistance(
//         _currentLocation!.latitude!,
//         _currentLocation!.longitude!,
//         destLat,
//         destLon,
//       );
//     }
//   }
//
//   double _calculateAngle(double startLat, double startLon, double endLat, double endLon) {
//     double dLon = endLon - startLon;
//     double y = sin(dLon) * cos(endLat);
//     double x = cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLon);
//     double brng = atan2(y, x);
//     brng = (brng * 180 / pi + 360) % 360; // Convert to degrees and normalize
//     return brng;
//   }
//
//   double _calculateDistance(double startLat, double startLon, double endLat, double endLon) {
//     const double R = 6371e3; // Radius of Earth in meters
//     double phi1 = startLat * pi / 180;
//     double phi2 = endLat * pi / 180;
//     double deltaPhi = (endLat - startLat) * pi / 180;
//     double deltaLambda = (endLon - startLon) * pi / 180;
//
//     double a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
//         cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//
//     double distance = R * c;
//     return distance; // Distance in meters
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _destLatController,
//               decoration: InputDecoration(labelText: 'Destination Latitude'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _destLonController,
//               decoration: InputDecoration(labelText: 'Destination Longitude'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             if (_currentLocation != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Current Latitude: ${_currentLocation!.latitude}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Current Longitude: ${_currentLocation!.longitude}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Angle: ${_angle.toStringAsFixed(2)}°',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Distance: ${(_distance / 1000).toStringAsFixed(2)} km',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//           ],
//         )
//     );
//   }
//
//   @override
//   void dispose() {
//     // _location.dispose();
//     // super.dispose();
//   }
// }
