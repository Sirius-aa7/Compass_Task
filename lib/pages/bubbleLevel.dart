import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BubbleLevelScreen extends StatefulWidget {
  @override
  _BubbleLevelScreenState createState() => _BubbleLevelScreenState();
}

class _BubbleLevelScreenState extends State<BubbleLevelScreen> {
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange : Color(0xFF4C4C4C);
    Color bubbleColor2 = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange :
    Color.fromRGBO(203, 219, 188, 10);
    Color bubbleColor3 = (_x.abs() < 0.1) ? Colors.orange : Colors.black;
    Color bubbleColor4 = (_y.abs() < 0.1) ? Colors.orange : Colors.black;

    // Calculate the horizontal angle
    double horizontalAngle = atan2(_x, sqrt(_y * _y + _z * _z)) * 180 / pi;
    // Calculate the vertical angle
    double verticalAngle = atan2(_y, sqrt(_x * _x + _z * _z)) * 180 / pi;

    // Clamping the values to keep the bubbles within the bounds of the bars
    double clampedX = (_x / 10).clamp(-10.0, 10.0);
    double clampedY = (_y / 10).clamp(-10.0, 10.0);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: screenWidth*0.8,
                          height: screenWidth*0.8,
                          child: SizedBox(
                            width: screenWidth*0.5,
                            height: screenWidth*0.5,
                            child: Image.asset(
                              'assets/images/bgrdBubble3.png',
                            ),
                          ),
                        ),

                        // Central bubble
                        Positioned(
                          left: screenWidth*0.4 + _x * 3 - 18,
                          top: screenWidth*0.4  - _y * 3 - 20,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: bubbleColor2,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        // Vertical bar
                        Positioned(
                          left: screenWidth * 6 / 8 - 2,
                          top: screenWidth*0.4 - 100,
                          child: Container(
                            width: 20,
                            height: 200,
                            color: Color.fromRGBO(203, 219, 188, 10),
                            child: Align(
                              alignment: Alignment(0, - clampedY),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bubbleColor4,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Horizontal bar
                        Positioned(
                          left: screenWidth*0.4 - 100,
                          top: screenWidth*0.8 - 20,
                          child: Container(
                            width: 200,
                            height: 20,
                            color: Color.fromRGBO(203, 219, 188, 10),
                            child: Align(
                              alignment: Alignment(clampedX, 0),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bubbleColor3,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Roll : ${(verticalAngle >= 0 ? 'U' : 'D')}${verticalAngle.abs().toStringAsFixed(1)}°',
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                        Text(
                          'Pitch : ${horizontalAngle >= 0 ? 'R' : 'L'}${horizontalAngle.abs().toStringAsFixed(1)}°',
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}




class BubbleLevelScreen2 extends StatefulWidget {
  @override
  _BubbleLevelScreen2State createState() => _BubbleLevelScreen2State();
}

class _BubbleLevelScreen2State extends State<BubbleLevelScreen2> {
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange : Color(0xFF4C4C4C);
    Color bubbleColor2 = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange :
    Color.fromRGBO(203, 219, 188, 10);
    Color bubbleColor3 = (_x.abs() < 0.1) ? Colors.orange : Colors.white;
    Color bubbleColor4 = (_y.abs() < 0.1) ? Colors.orange : Colors.white;

    // Calculate the horizontal angle
    double horizontalAngle = atan2(_x, sqrt(_y * _y + _z * _z)) * 180 / pi;
    // Calculate the vertical angle
    double verticalAngle = atan2(_y, sqrt(_x * _x + _z * _z)) * 180 / pi;

    // Clamping the values to keep the bubbles within the bounds of the bars
    double clampedX = (_x / 10).clamp(-10.0, 10.0);
    double clampedY = (_y / 10).clamp(-10.0, 10.0);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: screenWidth*0.8,
                        height: screenWidth*0.8,
                        child: SizedBox(
                          width: screenWidth*0.5,
                          height: screenWidth*0.5,
                          child: Image.asset(
                            'assets/images/kl.png',
                            // 'assets/images/negativeBubble.png',
                          ),
                        ),
                      ),

                      // Central bubble
                      Positioned(
                        left: screenWidth*0.4 + _x * 3 - 18,
                        top: screenWidth*0.4  - _y * 3 - 20,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: bubbleColor2,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      // Vertical bar
                      Positioned(
                        left: screenWidth * 6 / 8 - 2,
                        top: screenWidth*0.4 - 100,
                        child: Container(
                          width: 20,
                          height: 200,
                          color: Color.fromRGBO(203, 219, 188, 10),
                          child: Align(
                            alignment: Alignment(0, - clampedY),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: bubbleColor4,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Horizontal bar
                      Positioned(
                        left: screenWidth*0.4 - 100,
                        top: screenWidth*0.8 - 20,
                        child: Container(
                          width: 200,
                          height: 20,
                          color: Color.fromRGBO(203, 219, 188, 10),
                          child: Align(
                            alignment: Alignment(clampedX, 0),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: bubbleColor3,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Roll : ${(verticalAngle >= 0 ? 'U' : 'D')}${verticalAngle.abs().toStringAsFixed(1)}°',
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Pitch : ${horizontalAngle >= 0 ? 'L' : 'R'}${horizontalAngle.abs().toStringAsFixed(1)}°',
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}