// // // import 'package:flutter/animation.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:arnv/controllers/compass_controller.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:geocoding/geocoding.dart';
// // // import 'package:geolocator/geolocator.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // // import 'package:image_gallery_saver/image_gallery_saver.dart';
// // // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:provider/provider.dart';
// // // // import 'package:screenshot/screenshot.dart';
// // // import 'package:sprung/sprung.dart';
// // //
// // // import 'altitude.dart';
// // // import 'animated_toggle.dart';
// // // import 'buttons_beside_compass.dart';
// // // import 'lat_long.dart';
// // // import 'lat_long_2.dart';
// // //
// // // class MyWidget extends StatefulWidget {
// // //   const MyWidget({super.key});
// // //
// // //   @override
// // //   State<MyWidget> createState() => _MyWidgetState();
// // // }
// // //
// // // class _MyWidgetState extends State<MyWidget> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return const Placeholder();
// // //   }
// // // }
// // //
// // // class HomePage extends StatefulWidget {
// // //   const HomePage({super.key});
// // //
// // //   @override
// // //   State<HomePage> createState() => _HomePageState();
// // // }
// // //
// // // class _HomePageState extends State<HomePage> {
// // // //HomePage({Key? key}) : super(key: key);
// // //   //final screenshotController = ScreenshotController();
// // //   int _toggleValue = 0;
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     bool _isOn = false;
// // //
// // //     void _onToggle(bool value) {
// // //       setState(() {
// // //         _isOn = value;
// // //       });
// // //     }
// // //
// // //     final CompassController _compassController =
// // //         context.watch<CompassController>();
// // //     final double _screenWidth = MediaQuery.of(context).size.width;
// // //     final double _screenHeight = MediaQuery.of(context).size.height;
// // //     // print(_screenWidth);
// // //     Color buttonColor = Colors.blue;
// // //     int? degreeValue = _compassController.compassHeading?.round();
// // //     // we get the value of degrees in the above variable
// // //     if (degreeValue != null) {
// // //       if (degreeValue < 0) {
// // //         degreeValue += 360; // converting the scale from -179 to 180 -> 0 to 359
// // //       }
// // //     }
// // //
// // //     double? compassRotation = -(degreeValue!) / 360.0;
// // //     //print(compassRotation);
// // //     if (degreeValue == 359) {
// // //       compassRotation = 0.001;
// // //     }
// // //     // double? compassRotation = -((_compassController.compassHeading?.round()
// // //     //     ?? 0) /
// // //     //     360);
// // //     // if(compassRotation==-0.5){
// // //     //   compassRotation+=1;
// // //     // }
// // //     // if(compassRotation<0){
// // //     //   compassRotation=((_compassController.compassHeading ?? 0) /
// // //     //       360).abs() ;
// // //     // }else{
// // //     //   compassRotation*=-1;
// // //     // }
// // //     // rotation happening in animated rotation widget
// // //     // print(_compassController.compassHeading);
// // //     // print(compassRotation);
// // //     // if(_compassController.compassHeading == 180){
// // //     //   compassRotation=1/360; // not working >:?
// // //     // }
// // //
// // //     SystemChrome.setPreferredOrientations([
// // //       DeviceOrientation.portraitUp,
// // //     ]);
// // //     return
// // //         //Screenshot(
// // //         //  controller: screenshotController,
// // //         //child:
// // //         Scaffold(
// // //       body: Column(
// // //         mainAxisAlignment: MainAxisAlignment.start,
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Center(
// // //                   child: RoundedIconButton(
// // //                     icon: Icons.star,
// // //                     onPressed: () async {
// // //                       // Add your button press logic here
// // //                       // final image = await screenshotController.capture;
// // //                       // if (image == null) return;
// // //                       // await saveImage(image);
// // //                       print('Button Pressed!');
// // //                     },
// // //                   ),
// // //                 ),
// // //                 Center(
// // //                   child: RoundedIconButton(
// // //                     icon: Icons.settings,
// // //                     onPressed: () {
// // //                       // Add your button press logic here
// // //                       print('Button Pressed!');
// // //                     },
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           SizedBox(
// // //             height: MediaQuery.of(context).size.height * 0.45,
// // //             width: MediaQuery.of(context).size.width * 1.2,
// // //             child: Stack(
// // //               alignment: Alignment.center,
// // //               fit: StackFit.passthrough,
// // //               children: [
// // //                 // Background
// // //                 // Image.asset(
// // //                 //   'assets/images/bg.png',
// // //                 //   height: _screenHeight * 0.8,
// // //                 //   width: _screenWidth,
// // //                 //   opacity: const AlwaysStoppedAnimation(0.5),
// // //                 // ),
// // //                 // // Compass Dial Background
// // //                 Image.asset(
// // //                   'assets/images/dial3.png',
// // //                   // height: _screenHeight * 2, // * 1.5, //0.7
// // //                   // width: _screenWidth * 2, // * 1.5,
// // //                 ),
// // //                 // Compass Dial (Ticks)
// // //                 AnimatedRotation(
// // //                     duration: Duration(milliseconds: 10),
// // //                     curve: Curves.easeInOutCubic,
// // //                     turns: compassRotation,
// // //                     //turns: -(_compassController.compassHeading ?? 0) / 360,
// // //                     child: Image.asset(
// // //                       'assets/images/CompassLabel.png',
// // //                       // 'assets/images/ticks.png',
// // //                       height: _screenHeight * 2, //0.5,
// // //                       width: _screenWidth,
// // //                     )),
// // //                 // Compass Dial (Pointer)
// // //                 Image.asset(
// // //                   'assets/images/pointer.png',
// // //                   height: _screenHeight,
// // //                   width: _screenWidth,
// // //                 ),
// // //                 // Compass Display (Text)
// // //                 Center(
// // //                   child: Column(
// // //                     mainAxisSize: MainAxisSize.min,
// // //                     children: [
// // //                       Text(
// // //                         '${degreeValue}°',
// // //                         //'${_compassController.compassHeading?.round()}°',
// // //                         style: GoogleFonts.redHatDisplay(
// // //                           fontSize: 25,
// // //                           fontWeight: FontWeight.w900,
// // //                           color: const Color(0xFF4C4C4C),
// // //                         ),
// // //                       ),
// // //                       Text(
// // //                         '${_compassController.compassDirection}',
// // //                         style: GoogleFonts.redHatDisplay(
// // //                           fontSize: 10,
// // //                           fontWeight: FontWeight.bold,
// // //                           color: const Color(0xCC4C4C4C),
// // //                         ),
// // //                       ),
// // //                       GeoLocationApp2(),
// // //                     ],
// // //                   ),
// // //                 ),
// // //                 //Compass Display (Inner Shadow)
// // //                 // Image.asset(
// // //                 //   'assets/images/shadow.png',
// // //                 //   // height: _screenHeight * 1.2,
// // //                 //   // width: _screenWidth,
// // //                 // ),
// // //               ],
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Center(
// // //                   child: RoundedIconButton(
// // //                     icon: Icons.location_on,
// // //                     onPressed: () {
// // //                       // Add your button press logic here
// // //                       print('Button Pressed!');
// // //                     },
// // //                   ),
// // //                 ),
// // //                 Center(
// // //                   child: RoundedIconButton(
// // //                     icon: Icons.camera_alt_rounded,
// // //                     onPressed: () {
// // //                       // Add your button press logic here
// // //                       print('Button Pressed!');
// // //                     },
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           // Center(
// // //           //   child: SimpleToggle(
// // //           //     value: false, // Pass the initial state
// // //           //     onToggle: _onToggle, // Callback for state change
// // //           //   ),
// // //           // ),
// // //           // AnimatedToggle(
// // //           //   values: ['P', 'C'],
// // //           //   onToggleCallback: (value) {
// // //           //     setState(() {
// // //           //       _toggleValue = value;
// // //           //     });
// // //           //   },
// // //           //   buttonColor: const Color(0xFF0A3157),
// // //           //   backgroundColor: const Color(0xFFB5C1CC),
// // //           //   textColor: const Color(0xFFFFFFFF),
// // //           // ),
// // //           // Text('Toggle Value : $_toggleValue'),
// // //           GeoLocationApp(),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // // Future<String> saveImage(Uint8List bytes) async {
// // // //   await [Permission.storage].request();
// // //
// // // //   final time = DateTime.now()
// // // //       .toIso8601String()
// // // //       .replaceAll('.', '-')
// // // //       .replaceAll(':', '-');
// // // //   final name = "screenshot_$time";
// // // //   final result = await ImageGallerySaver.saveImage(bytes, name: name);
// // // //   return result['filePath'];
// // // // }
// // // // saveImage(Future<Uint8List?> Function({Duration delay = const Duration(milliseconds: 20), double? pixelRatio}) image) async {
// // // // await [Permission.storage].request();
// // //
// // // //   final time = DateTime.now()
// // // //       .toIso8601String()
// // // //       .replaceAll('.', '-')
// // // //       .replaceAll(':', '-');
// // // //   final name = "screenshot_$time";
// // // //   final result = await ImageGallerySaver.saveImage(bytes, name: name);
// // // //   return result['filePath'];
// // // // }
// //
// //
// // import 'package:flutter/animation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:arnv/controllers/compass_controller.dart';
// // import 'package:flutter/services.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:provider/provider.dart';
// // import 'altitude.dart';
// // import 'animated_toggle.dart';
// // import 'buttons_beside_compass.dart';
// // import 'lat_long.dart';
// // import 'lat_long_2.dart';
// //
// // class HomePage extends StatefulWidget {
// //   const HomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //   late CameraController _cameraController;
// //   late Future<void> _initializeCameraFuture;
// //   bool _isCameraOn = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeCamera();
// //   }
// //
// //   void _initializeCamera() async {
// //     final cameras = await availableCameras();
// //     final firstCamera = cameras.first;
// //
// //     _cameraController = CameraController(
// //       firstCamera,
// //       ResolutionPreset.medium,
// //     );
// //
// //     _initializeCameraFuture = _cameraController.initialize().then((_) {
// //       setState(() {});
// //     }).catchError((error) {
// //       setState(() {});
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _cameraController.dispose(); // Dispose the controller when no longer needed
// //     super.dispose();
// //   }
// //
// //   void _toggleCamera() {
// //     setState(() {
// //       _isCameraOn = !_isCameraOn;
// //       if (_isCameraOn) {
// //         if (!_cameraController.value.isInitialized) {
// //           _initializeCameraFuture = _cameraController.initialize().then((_) {
// //             setState(() {});
// //           }).catchError((error) {
// //             setState(() {});
// //           });
// //         }
// //       } else {
// //         _cameraController.dispose();
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final CompassController _compassController =
// //     context.watch<CompassController>();
// //     final double _screenWidth = MediaQuery.of(context).size.width;
// //     final double _screenHeight = MediaQuery.of(context).size.height;
// //     Color buttonColor = Colors.blue;
// //     int? degreeValue = _compassController.compassHeading?.round();
// //     if (degreeValue != null) {
// //       if (degreeValue < 0) {
// //         degreeValue += 360;
// //       }
// //     }
// //
// //     double? compassRotation = -(degreeValue!) / 360.0;
// //
// //     if (degreeValue == 359) {
// //       compassRotation = 0.001;
// //     }
// //
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.portraitUp,
// //     ]);
// //
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Center(
// //                   child: RoundedIconButton(
// //                     icon: Icons.star,
// //                     onPressed: () async {
// //                       print('Button Pressed!');
// //                     },
// //                   ),
// //                 ),
// //                 Center(
// //                   child: RoundedIconButton(
// //                     icon: Icons.settings,
// //                     onPressed: () {
// //                       print('Button Pressed!');
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(
// //             height: MediaQuery.of(context).size.height * 0.45,
// //             width: MediaQuery.of(context).size.width * 1.2,
// //             child: Stack(
// //               alignment: Alignment.center,
// //               fit: StackFit.passthrough,
// //               children: [
// //                 Image.asset(
// //                   'assets/images/dial3.png',
// //                 ),
// //                 AnimatedRotation(
// //                     duration: Duration(milliseconds: 10),
// //                     curve: Curves.easeInOutCubic,
// //                     turns: compassRotation,
// //                     child: Image.asset(
// //                       'assets/images/CompassLabel.png',
// //                     )),
// //                 Image.asset(
// //                   'assets/images/pointer.png',
// //                 ),
// //                 Center(
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       Text(
// //                         '${degreeValue}°',
// //                         style: GoogleFonts.redHatDisplay(
// //                           fontSize: 25,
// //                           fontWeight: FontWeight.w900,
// //                           color: const Color(0xFF4C4C4C),
// //                         ),
// //                       ),
// //                       Text(
// //                         '${_compassController.compassDirection}',
// //                         style: GoogleFonts.redHatDisplay(
// //                           fontSize: 10,
// //                           fontWeight: FontWeight.bold,
// //                           color: const Color(0xCC4C4C4C),
// //                         ),
// //                       ),
// //                       GeoLocationApp2(),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Center(
// //                   child: RoundedIconButton(
// //                     icon: Icons.location_on,
// //                     onPressed: () {
// //                       print('Button Pressed!');
// //                     },
// //                   ),
// //                 ),
// //                 Center(
// //                   child: RoundedIconButton(
// //                     icon: Icons.camera_alt_rounded,
// //                     onPressed: () {
// //                       _toggleCamera();
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           GeoLocationApp(),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:arnv/controllers/compass_controller.dart';
// import 'package:flutter/services.dart';
// import 'altitude.dart';
// import 'buttons_beside_compass.dart';
// import 'lat_long.dart';
// import 'lat_long_2.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late CameraController _cameraController;
//   late Future<void> _initializeCameraFuture;
//   bool _isCameraOn = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   void _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//
//     _cameraController = CameraController(
//       firstCamera,
//       ResolutionPreset.medium,
//     );
//
//     _initializeCameraFuture = _cameraController.initialize().then((_) {
//       setState(() {});
//     }).catchError((error) {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _cameraController.dispose(); // Dispose the controller when no longer needed
//     super.dispose();
//   }
//
//   void _toggleCamera() {
//     setState(() {
//       _isCameraOn = !_isCameraOn;
//       if (_isCameraOn) {
//         if (!_cameraController.value.isInitialized) {
//           _initializeCameraFuture = _cameraController.initialize().then((_) {
//             setState(() {});
//           }).catchError((error) {
//             setState(() {});
//           });
//         }
//       } else {
//         _cameraController.dispose();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final CompassController _compassController =
//     context.watch<CompassController>();
//     final double _screenWidth = MediaQuery.of(context).size.width;
//     final double _screenHeight = MediaQuery.of(context).size.height;
//     Color buttonColor = Colors.blue;
//     int? degreeValue = _compassController.compassHeading?.round();
//     if (degreeValue != null) {
//       if (degreeValue < 0) {
//         degreeValue += 360;
//       }
//     }
//
//     double? compassRotation = -(degreeValue!) / 360.0;
//
//     if (degreeValue == 359) {
//       compassRotation = 0.001;
//     }
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Center(
//                   child: RoundedIconButton(
//                     icon: Icons.star,
//                     onPressed: () async {
//                       print('Button Pressed!');
//                     },
//                   ),
//                 ),
//                 Center(
//                   child: RoundedIconButton(
//                     icon: Icons.settings,
//                     onPressed: () {
//                       print('Button Pressed!');
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.45,
//             width: MediaQuery.of(context).size.width * 1.2,
//             child: Stack(
//               alignment: Alignment.center,
//               fit: StackFit.passthrough,
//               children: [
//                 Image.asset(
//                   'assets/images/dial3.png',
//                 ),
//                 AnimatedRotation(
//                     duration: Duration(milliseconds: 10),
//                     curve: Curves.easeInOutCubic,
//                     turns: compassRotation,
//                     child: Image.asset(
//                       'assets/images/CompassLabel.png',
//                     )),
//                 Image.asset(
//                   'assets/images/pointer.png',
//                 ),
//                 Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         '${degreeValue}°',
//                         style: GoogleFonts.redHatDisplay(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w900,
//                           color: const Color(0xFF4C4C4C),
//                         ),
//                       ),
//                       Text(
//                         '${_compassController.compassDirection}',
//                         style: GoogleFonts.redHatDisplay(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xCC4C4C4C),
//                         ),
//                       ),
//                       GeoLocationApp2(),
//                       if (_isCameraOn) Text('I am awesome!'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Center(
//                   child: RoundedIconButton(
//                     icon: Icons.location_on,
//                     onPressed: () {
//                       print('Button Pressed!');
//                     },
//                   ),
//                 ),
//                 Center(
//                   child: RoundedIconButton(
//                     icon: Icons.camera_alt_rounded,
//                     onPressed: () {
//                       _toggleCamera();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GeoLocationApp(),
//         ],
//       ),
//     );
//   }
// }
//
// // class RoundedIconButton extends StatelessWidget {
// //   final IconData icon;
// //   final VoidCallback onPressed;
//
// //   const RoundedIconButton({
// //     Key? key,
// //     required this.icon,
// //     required this.onPressed,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return IconButton(
// //       icon: Icon(icon),
// //       onPressed: onPressed,
// //       iconSize: 32,
// //       color: Colors.white,
// //       padding: EdgeInsets.all(16),
// //       splashRadius: 24,
// //       alignment: Alignment.center,
// //     );
// //   }
// // }
//


import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:arnv/controllers/compass_controller.dart';
import 'package:flutter/services.dart';
import 'altitude.dart';
import 'buttons_beside_compass.dart';
import 'lat_long.dart';
import 'lat_long_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraFuture;
  bool _isCameraOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeCameraFuture = _cameraController.initialize().then((_) {
      setState(() {});
    }).catchError((error) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }

  void _toggleCamera() async {
    setState(() {
      _isCameraOn = !_isCameraOn;
      if (_isCameraOn) {
        if (!_cameraController.value.isInitialized) {
          _initializeCameraFuture = _cameraController.initialize().then((_) {
            setState(() {});
          }).catchError((error) {
            setState(() {});
          });
        }
      } else {
        _cameraController.dispose();
        _cameraController = CameraController(
          _cameraController.description,
          ResolutionPreset.medium,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final CompassController _compassController =
    context.watch<CompassController>();
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    Color buttonColor = Colors.blue;
    int? degreeValue = _compassController.compassHeading?.round();
    if (degreeValue != null) {
      if (degreeValue < 0) {
        degreeValue += 360;
      }
    }

    double? compassRotation = -(degreeValue!) / 360.0;

    if (degreeValue == 359) {
      compassRotation = 0.001;
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: RoundedIconButton(
                    icon: Icons.star,
                    onPressed: () async {
                      print('Button Pressed!');
                    },
                  ),
                ),
                Center(
                  child: RoundedIconButton(
                    icon: Icons.settings,
                    onPressed: () {
                      print('Button Pressed!');
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 1.2,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: [
                Image.asset(
                  'assets/images/dial3.png',
                ),
                AnimatedRotation(
                    duration: Duration(milliseconds: 10),
                    curve: Curves.easeInOutCubic,
                    turns: compassRotation,
                    child: Image.asset(
                      'assets/images/CompassLabel.png',
                    )),
                Image.asset(
                  'assets/images/pointer.png',
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${degreeValue}°',
                        style: GoogleFonts.redHatDisplay(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Text(
                        '${_compassController.compassDirection}',
                        style: GoogleFonts.redHatDisplay(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xCC4C4C4C),
                        ),
                      ),
                      GeoLocationApp2(),
                      // if (_isCameraOn) Text('I am awesome!'),
                    ],
                  ),
                ),
                if (_isCameraOn)
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      FutureBuilder<void>(
                        future: _initializeCameraFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return CameraPreview(_cameraController);
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 1.2,
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.passthrough,
                          children: [
                            AnimatedRotation(
                                duration: Duration(milliseconds: 10),
                                curve: Curves.easeInOutCubic,
                                turns: compassRotation,
                                child: Image.asset(
                                  'assets/images/CompassLabel2.png',
                                )),
                            Image.asset(
                              'assets/images/pointer.png',
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${degreeValue}°',
                                    style: GoogleFonts.redHatDisplay(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white
                                      // color: const Color(0xFF4C4C4C),
                                    ),
                                  ),
                                  Text(
                                    '${_compassController.compassDirection}',
                                    style: GoogleFonts.redHatDisplay(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GeoLocationApp3(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: RoundedIconButton(
                    icon: Icons.location_on,
                    onPressed: () {
                      print('Button Pressed!');
                    },
                  ),
                ),
                Center(
                  child: RoundedIconButton(
                    icon: Icons.camera_alt_rounded,
                    onPressed: () {
                      _toggleCamera();
                    },
                  ),
                ),
              ],
            ),
          ),
          GeoLocationApp(),
        ],
      ),
    );
  }
}

