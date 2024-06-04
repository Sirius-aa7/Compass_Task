import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Get available cameras
  cameras = await availableCameras();
  runApp(CameraApp());
}

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize CameraController inside build
    final CameraController _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    final Future<void> _initializeControllerFuture = _cameraController.initialize();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Preview'),
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Display camera preview
              return CameraPreview(_cameraController);
            } else {
              // Display a loader while initializing
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

