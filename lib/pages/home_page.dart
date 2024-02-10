import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:arnv/controllers/compass_controller.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompassController _compassController =
    context.watch<CompassController>();
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    int? degreeValue = _compassController.compassHeading?.round();
    // we get the value of degrees in the above variable
    if(degreeValue! <0 ){
      degreeValue+=360; // converting the scale from -179 to 180 -> 0 to 359
    }
    double? compassRotation = -(_compassController.compassHeading ?? 0) / 360 ;
    // rotation happening in animated rotation widget
    if(_compassController.compassHeading == 180){
      compassRotation=0; // not working >:?
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Color(0xFFF2F1EE),
              Color(0xFFE4E2DC),
            ],
          ),
        ),
        child: SizedBox.expand(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background
                  Image.asset(
                    'assets/images/bg.png',
                    height: _screenHeight * 0.8,
                    width: _screenWidth,
                    opacity: const AlwaysStoppedAnimation(0.5),
                  ),
                  // Compass Dial Background
                  Image.asset(
                    'assets/images/dial.png',
                    height: _screenHeight*0.8,
                    width: _screenWidth,
                  ),
                  // Compass Dial (Ticks)
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 1000),
                    curve: Sprung.criticallyDamped,
                    turns: compassRotation,
                    //turns: -(_compassController.compassHeading ?? 0) / 360,
                    child: Image.asset(
                      'assets/images/ticks.png',
                      height: _screenHeight*0.8,
                      width: _screenWidth,
                    ),
                  ),
                  // Compass Dial (Pointer)
                  Image.asset(
                    'assets/images/pointer.png',
                    height: _screenHeight*0.8,
                    width: _screenWidth,
                  ),
                  // Compass Display (Text)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          '${degreeValue}°',
                          //'${_compassController.compassHeading?.round()}°',
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                        Text(
                          '${_compassController.compassDirection}',
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xCC4C4C4C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Compass Display (Inner Shadow)
                  Image.asset(
                    'assets/images/shadow.png',
                    height: _screenHeight*0.8,
                    width: _screenWidth,
                  ),
                ],
              ),
              // Display latitude, longitude values
              GeoLocationApp(),
            ],
          ),
        ),

      ),
    );
  }
}

class GeoLocationApp extends StatefulWidget {
  const GeoLocationApp({Key? key}) : super(key: key);
  @override
  State<GeoLocationApp> createState() => _GeoLocationAppState();
}

class _GeoLocationAppState extends State<GeoLocationApp> {

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAddress = "";

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if(!servicePermission){
      print("service disabled");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      // isse interactive box ayega for asking permission
    }

    return Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates () async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates
        (_currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed : () async {
                _currentLocation = await _getCurrentLocation();
                await _getAddressFromCoordinates();
                print("${_currentLocation}");
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty
                .all<Color>(Color.fromRGBO(203, 219, 188, 60))),
              child: Text("Get Location",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Center(
            child: Column(
              children: [
                Text(" Click the button above to grant location access",
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4C4C4C),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left:  90)),
              Text("Latitude:",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(15)),
              Text("${_currentLocation?.latitude}",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left:  90)),
              Text("Longitude:",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("${_currentLocation?.longitude}",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
