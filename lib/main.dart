import 'package:arnv/modules/module2.dart';
import 'package:arnv/modules/module3.dart';
import 'package:arnv/modules/navigator.dart';
import 'package:arnv/pages/app_state.dart';
import 'package:arnv/pages/bubbleLevel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arnv/pages/home_page.dart';
import 'package:arnv/controllers/compass_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CompassController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compass Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      // home: HomePage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final List<Widget> screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        backgroundColor: Color.fromRGBO(203, 219, 188, 10),
        actions: [
          PopupMenuButton<int>(
            onSelected: (int index) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screens[index]),
              );
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('Screen 1')),
              PopupMenuItem(value: 1, child: Text('Screen 2')),
              PopupMenuItem(value: 2, child: Text('Screen 3')),
              PopupMenuItem(value: 3, child: Text('Screen 4')),
              PopupMenuItem(value: 4, child: Text('Screen 5')),
              PopupMenuItem(value: 5, child: Text('Screen 6')),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(203, 219, 188, 10),
              ),
              child: Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Module 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Module 2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen2()),
                );
              },
            ),
            ListTile(
              title: Text('Module 3'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen3()),
                );
              },
            ),
            ListTile(
              title: Text('Module 4'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen4()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [Column(
                children: [
                  Image.asset('assets/images/CompassLabel.png', width:100, height:100),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(203, 219, 188, 10),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text('Module 1'),
                  ),
                ],
              ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
              [Column(
                children: [
                  Image.asset('assets/images/CompassLabel.png', width:100, height:100),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(203, 219, 188, 10),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Screen2()),
                      );
                    },
                    child: Text('Module 2'),
                  ),
                ],
              ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [Column(
                children: [
                  Image.asset('assets/images/CompassLabel.png', width:100, height:100),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(203, 219, 188, 10),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Screen3()),
                      );
                    },
                    child: Text('Module 3'),
                  ),
                ],
              ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
              [Column(
                children: [
                  Image.asset('assets/images/CompassLabel.png', width:100, height:100),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(203, 219, 188, 10),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Screen4()),
                      );
                    },
                    child: Text('Module 4'),
                  ),
                ],
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      child: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      child: Scaffold(
        body: RadarChartScreen(),
      ),
    );
  }
}

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      child: Scaffold(
        body: TargetChart(),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      child: Scaffold(
        body: NavigationPage()
      ),
    );
  }
}

class SwipeNavigator extends StatelessWidget {
  final Widget child;

  SwipeNavigator({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}

