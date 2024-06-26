import 'package:arnv/modules/module2.dart';
import 'package:arnv/pages/sensorCode.dart';
import 'package:arnv/pages/settingsPage.dart';
import 'package:arnv/services/timer.dart';
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
import 'bubbleLevel.dart';
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
  final PageController _pageController = PageController();
  bool _isCameraOn = false;
  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
        // ResolutionPreset.ultraHigh,
      );

      _initializeCameraFuture = _cameraController.initialize();
      await _initializeCameraFuture;
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    // super.dispose();
  }

  void _toggleCamera() async {
    if (_isCameraOn) {
      await _cameraController.dispose();
      setState(() {
        _isCameraOn = false;
      });
    } else {
      setState(() {
        _isCameraOn = true;
      });
      _initializeCamera();
    }
  }

  GlobalKey _globalKey = GlobalKey();

  Future<void> _captureCompleteScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 4.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List screenshot = byteData!.buffer.asUint8List();

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

  // Method to toggle the torch
  void _toggleTorch() async {
    try {
      if (_isTorchOn) {
        await _cameraController.setFlashMode(FlashMode.off);
      } else {
        await _cameraController.setFlashMode(FlashMode.torch);
      }
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return ButtonOverlayContent();
      },
    );
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final CompassController _compassController =
        context.watch<CompassController>();
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    int? degreeValue = _compassController.compassHeading?.round();
    if (degreeValue != null && degreeValue < 0) {
      degreeValue += 360;
    }

    double? compassRotation =
        degreeValue != null ? -(degreeValue / 360.0) : 0.0;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Need to call RadarChartScreen within MaterialApp or Scaffold widget,
    // error otherwise
    // return Scaffold(body: RadarChartScreen());
    return Scaffold(
      body: RepaintBoundary(
        key: _globalKey,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            if (_isCameraOn)
              FutureBuilder<void>(
                future: _initializeCameraFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _cameraController.value.aspectRatio,
                      child: CameraPreview(_cameraController),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 35.0, 6.0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 145,
                              child: TimeDisplayPage()),
                          RoundedIconButton(
                              icon: Icons.star,
                              onPressed: () {
                                _captureCompleteScreenshot();
                                setState(() {});
                              }),
                          SizedBox(
                              width: 145,
                              // child: TimeDisplayPage()
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 1.2,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          PageView(
                            controller: _pageController,
                            children: [
                              !_isCameraOn
                                  ? Stack(
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
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/pointer.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '${degreeValue}° ${_compassController.compassDirection}',
                                                style:
                                                    GoogleFonts.redHatDisplay(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      const Color(0xFF4C4C4C),
                                                ),
                                              ),
                                              GeoLocationApp2(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.passthrough,
                                      children: [
                                        AnimatedRotation(
                                            duration:
                                                Duration(milliseconds: 10),
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
                                                style:
                                                    GoogleFonts.redHatDisplay(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white),
                                              ),
                                              Text(
                                                '${_compassController.compassDirection}',
                                                style:
                                                    GoogleFonts.redHatDisplay(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              GPSDemo(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              !_isCameraOn
                                  ? BubbleLevelScreen()
                                  : BubbleLevelScreen2(),
                            ],
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: RoundedIconButton(
                                icon: Icons.flashlight_on,
                                onPressed: () {
                                  _toggleTorch();
                                  setState(() {});
                                }),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: RoundedIconButton(
                              icon: Icons.settings,
                              onPressed: () {
                                print('Button Pressed!');
                                _showOverlay(context);
                                print("settings");
                                setState(() {});
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: RoundedIconButton(
                              icon: Icons.location_on,
                              onPressed: () {
                                print('Button Pressed!');
                                setState(() {});
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: RoundedIconButton(
                              icon: Icons.camera_alt_rounded,
                              onPressed: () {
                                _toggleCamera();
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(16.0, 5, 16.0, 16.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       RoundedIconButton(
                    //         icon: Icons.navigation_sharp,
                    //         onPressed: () {
                    //           print('Button Pressed!');
                    //           setState(() {});
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    !_isCameraOn ? GeoLocationApp() : GeoLocationCameraOn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// // GeoLocationApp() has 6 cases with 3 toggle buttons

// P-C for checking if Range calculation or Conversion in units
// A-B for checking if primary units is Lat-Lon-Alt or E-N-Alt
// R-S for checking if primary input to Range, Bearing and AOS calcn

// when P-C and A-B  :: We are doing Range, Bearing and AOS calculation from
// Lat-Lon-Alt values as input

// when P-C and A->B :: We are doing Range, Bearing and AOS calculation from
// E-N-Alt values as input

// when P->C and A-B :: We are doing E-N-Alt calculation from Lat-Lon-Alt
// values as input

// when P->C and A->B :: We are doing Lat-Lan-Alt calculation from E-N-Alt
// values as input

// Similarly for GeoLocationCameraOn()