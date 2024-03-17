import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:arnv/controllers/compass_controller.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:sprung/sprung.dart';

import 'altitude.dart';
import 'animated_toggle.dart';
import 'buttons_beside_compass.dart';
import 'lat_long.dart';
import 'lat_long_2.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//HomePage({Key? key}) : super(key: key);
  //final screenshotController = ScreenshotController();
  int _toggleValue = 0;
  @override
  Widget build(BuildContext context) {
    final CompassController _compassController =
        context.watch<CompassController>();
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    // print(_screenWidth);
    Color buttonColor = Colors.blue;
    int? degreeValue = _compassController.compassHeading?.round();
    // we get the value of degrees in the above variable
    if (degreeValue != null) {
      if (degreeValue < 0) {
        degreeValue += 360; // converting the scale from -179 to 180 -> 0 to 359
      }
    }

    double? compassRotation = -(degreeValue!) / 360.0;
    //print(compassRotation);
    if (degreeValue == 359) {
      compassRotation = 0.001;
    }
    // double? compassRotation = -((_compassController.compassHeading?.round()
    //     ?? 0) /
    //     360);
    // if(compassRotation==-0.5){
    //   compassRotation+=1;
    // }
    // if(compassRotation<0){
    //   compassRotation=((_compassController.compassHeading ?? 0) /
    //       360).abs() ;
    // }else{
    //   compassRotation*=-1;
    // }
    // rotation happening in animated rotation widget
    // print(_compassController.compassHeading);
    // print(compassRotation);
    // if(_compassController.compassHeading == 180){
    //   compassRotation=1/360; // not working >:?
    // }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return
        //Screenshot(
        //  controller: screenshotController,
        //child:
        Scaffold(
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
                      // Add your button press logic here
                      // final image = await screenshotController.capture;
                      // if (image == null) return;
                      // await saveImage(image);
                      print('Button Pressed!');
                    },
                  ),
                ),
                Center(
                  child: RoundedIconButton(
                    icon: Icons.settings,
                    onPressed: () {
                      // Add your button press logic here
                      print('Button Pressed!');
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: [
                // Background
                // Image.asset(
                //   'assets/images/bg.png',
                //   height: _screenHeight * 0.8,
                //   width: _screenWidth,
                //   opacity: const AlwaysStoppedAnimation(0.5),
                // ),
                // // Compass Dial Background
                Image.asset(
                  'assets/images/dial.png',
                  height: _screenHeight * 0.7, //0.8
                  width: _screenWidth,
                ),
                // Compass Dial (Ticks)
                AnimatedRotation(
                    duration: Duration(milliseconds: 10),
                    curve: Curves.easeInOutCubic,
                    turns: compassRotation,
                    //turns: -(_compassController.compassHeading ?? 0) / 360,
                    child: Image.asset(
                      'assets/images/ticks.png',
                      height: _screenHeight * 0.7, //0.5,
                      width: _screenWidth,
                    )),
                // Compass Dial (Pointer)
                Image.asset(
                  'assets/images/pointer.png',
                  height: _screenHeight * 0.7,
                  width: _screenWidth,
                ),
                // Compass Display (Text)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${degreeValue}°',
                        //'${_compassController.compassHeading?.round()}°',
                        style: GoogleFonts.redHatDisplay(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Text(
                        '${_compassController.compassDirection}',
                        style: GoogleFonts.redHatDisplay(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xCC4C4C4C),
                        ),
                      ),
                      GeoLocationApp2(),
                    ],
                  ),
                ),
                // Compass Display (Inner Shadow)
                Image.asset(
                  'assets/images/shadow.png',
                  height: _screenHeight * 0.7,
                  width: _screenWidth,
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
                      // Add your button press logic here
                      print('Button Pressed!');
                    },
                  ),
                ),
                Center(
                  child: RoundedIconButton(
                    icon: Icons.camera_alt_rounded,
                    onPressed: () {
                      // Add your button press logic here
                      print('Button Pressed!');
                    },
                  ),
                ),
              ],
            ),
          ),
          // AnimatedToggle(
          //   values: ['English', 'Arabic'],
          //   onToggleCallback: (value) {
          //     setState(() {
          //       _toggleValue = value;
          //     });
          //   },
          //   buttonColor: const Color(0xFF0A3157),
          //   backgroundColor: const Color(0xFFB5C1CC),
          //   textColor: const Color(0xFFFFFFFF),
          // ),
          // Text('Toggle Value : $_toggleValue'),
          GeoLocationApp(),
        ],
      ),
    );
  }
}

// Future<String> saveImage(Uint8List bytes) async {
//   await [Permission.storage].request();

//   final time = DateTime.now()
//       .toIso8601String()
//       .replaceAll('.', '-')
//       .replaceAll(':', '-');
//   final name = "screenshot_$time";
//   final result = await ImageGallerySaver.saveImage(bytes, name: name);
//   return result['filePath'];
// }
// saveImage(Future<Uint8List?> Function({Duration delay = const Duration(milliseconds: 20), double? pixelRatio}) image) async {
// await [Permission.storage].request();

//   final time = DateTime.now()
//       .toIso8601String()
//       .replaceAll('.', '-')
//       .replaceAll(':', '-');
//   final name = "screenshot_$time";
//   final result = await ImageGallerySaver.saveImage(bytes, name: name);
//   return result['filePath'];
// }
