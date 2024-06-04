import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BubbleLevelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble Level',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BubbleLevelScreen(),
    );
  }
}

class BubbleLevelScreen extends StatefulWidget {
  @override
  _BubbleLevelScreenState createState() => _BubbleLevelScreenState();
}

class _BubbleLevelScreenState extends State<BubbleLevelScreen> {
  double _x = 0.0;
  double _y = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
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

    double a = double.parse(_x.toStringAsFixed(2));
    a = ((a* (180/pi))%360);
    double b = double.parse(_y.toStringAsFixed(2));
    b = ((b* (180/pi))%360);

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
                          'Bearing(_x) value: ${a.toStringAsFixed(1)}°',
                          style: GoogleFonts.redHatDisplay(
                            fontSize:  12,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                        Text(
                          'AOS (_y) value: ${b.toStringAsFixed(1)}°',
                          style: GoogleFonts.redHatDisplay(
                            fontSize:  12,
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

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
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

    double a = double.parse(_x.toStringAsFixed(2));
    a = ((a* (180/pi))%360);
    double b = double.parse(_y.toStringAsFixed(2));
    b = ((b* (180/pi))%360);
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
                        'Bearing(_x) value: ${a.toStringAsFixed(1)}°',
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'AOS(_y) value: ${b.toStringAsFixed(1)}°',
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