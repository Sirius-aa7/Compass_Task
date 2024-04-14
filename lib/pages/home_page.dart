import 'package:arnv/pages/sensorCode.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:arnv/controllers/compass_controller.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
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

  GlobalKey _globalKey = GlobalKey();

  Future<void> _captureCompleteScreenshot() async {
    try {
      RenderRepaintBoundary boundary =
      _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 4.0 ,); // Use
      // pixelRatio: 1.0 to capture the entire screen
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List screenshot = byteData!.buffer.asUint8List();

      // Save the complete screenshot to the device's gallery
      final result = await ImageGallerySaver.saveImage(screenshot);
      print('Complete screenshot saved to: $result');

      Fluttertoast.showToast(
        msg: "Screenshot saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      print('Error saving complete screenshot: $e');
    }
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
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Colors.white,
          child: Column(
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
                        onPressed: _captureCompleteScreenshot,
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
                          // GPSDemo(),
                          GeoLocationApp2(),
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
                                      GPSDemo(),
                                      //GeoLocationApp3(),
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
        ),
      ),
    );
  }
}

