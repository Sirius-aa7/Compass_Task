import 'package:flutter/material.dart';

class ENACoordinateConverter extends StatefulWidget {
  @override
  _ENACoordinateConverterState createState() => _ENACoordinateConverterState();
}

class _ENACoordinateConverterState extends State<ENACoordinateConverter> {
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController eastingController = TextEditingController();
  final TextEditingController northingController = TextEditingController();
  final TextEditingController altitudeController = TextEditingController();

  String convertedDMS = '';
  String convertedDegMin = '';
  String convertedDeg = '';

  void _updateConversions() {
    setState(() {
      // Add your conversion logic here
      // For demonstration purposes, we'll just concatenate the input values
      convertedDMS = 'Lat: ${zoneController.text}° ${eastingController.text}\' ${northingController.text}" N, Long: ${zoneController.text}° ${eastingController.text}\' ${northingController.text}" E, Alt: ${altitudeController.text}m';
      convertedDegMin = 'Lat: ${zoneController.text}° ${eastingController.text}.${northingController.text}\' N, Long: ${zoneController.text}° ${eastingController.text}.${northingController.text}\' E, Alt: ${altitudeController.text}m';
      convertedDeg = 'Lat: ${zoneController.text}.${eastingController.text}${northingController.text}° N, Long: ${zoneController.text}.${eastingController.text}${northingController.text}° E, Alt: ${altitudeController.text}m';
    });
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
                  controller: zoneController,
                  decoration: InputDecoration(
                    labelText: 'Zone',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _updateConversions(),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: eastingController,
                  decoration: InputDecoration(
                    labelText: 'Easting',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _updateConversions(),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: northingController,
                  decoration: InputDecoration(
                    labelText: 'Northing',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _updateConversions(),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: altitudeController,
                  decoration: InputDecoration(
                    labelText: 'Altitude',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _updateConversions(),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Lat/Long/Alt (DMS): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(convertedDMS),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Lat/Long/Alt (Degrees Minutes): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(convertedDegMin),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Lat/Long/Alt (Degrees): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(convertedDeg),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
