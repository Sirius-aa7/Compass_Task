import 'package:flutter/material.dart';

class CoordinateConverter extends StatefulWidget {
  @override
  _CoordinateConverterState createState() => _CoordinateConverterState();
}

class _CoordinateConverterState extends State<CoordinateConverter> {
  final TextEditingController latDegController = TextEditingController();
  final TextEditingController latMinController = TextEditingController();
  final TextEditingController latSecController = TextEditingController();

  final TextEditingController lonDegController = TextEditingController();
  final TextEditingController lonMinController = TextEditingController();
  final TextEditingController lonSecController = TextEditingController();

  final TextEditingController altController = TextEditingController();

  double convertedLatDegMin = 0.0;
  double convertedLonDegMin = 0.0;

  double convertedLatDeg = 0.0;
  double convertedLonDeg = 0.0;

  double easting = 0.0;
  double northing = 0.0;
  double convertedAlt = 0.0;

  void _updateConversions() {
    setState(() {
      // Convert latitude and longitude from DMS to degrees and minutes
      double latDeg = double.tryParse(latDegController.text) ?? 0;
      double latMin = double.tryParse(latMinController.text) ?? 0;
      double latSec = double.tryParse(latSecController.text) ?? 0;

      double lonDeg = double.tryParse(lonDegController.text) ?? 0;
      double lonMin = double.tryParse(lonMinController.text) ?? 0;
      double lonSec = double.tryParse(lonSecController.text) ?? 0;

      double alt = double.tryParse(altController.text) ?? 0;

      convertedLatDegMin = latDeg + (latMin / 60) + (latSec / 3600);
      convertedLonDegMin = lonDeg + (lonMin / 60) + (lonSec / 3600);

      convertedLatDeg = convertedLatDegMin;
      convertedLonDeg = convertedLonDegMin;

      // Conversion to UTM (Easting, Northing) - using simplified formula
      // Note: For real applications, use a proper library for accurate conversion
      easting = convertedLonDeg * 111320; // Simplified conversion factor
      northing = convertedLatDeg * 110540; // Simplified conversion factor
      convertedAlt = alt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Input fields for Latitude, Longitude and Altitude
          Row(
            children: [
              _buildCoordinateInput('Lat (DMS)', latDegController, latMinController, latSecController),
              _buildCoordinateInput('Lon (DMS)', lonDegController, lonMinController, lonSecController),
              _buildSingleInput('Alt (m)', altController),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _updateConversions,
            child: Text('Convert'),
          ),
          SizedBox(height: 20),
          // Display converted values
          _buildConvertedRow('Degrees Minutes', '$convertedLatDegMin, $convertedLonDegMin'),
          _buildConvertedRow('Degrees', '$convertedLatDeg, $convertedLonDeg'),
          _buildConvertedRow('Easting, Northing, Altitude', '$easting, $northing, $convertedAlt'),
        ],
      ),
    );
  }

  Widget _buildCoordinateInput(String label, TextEditingController degController, TextEditingController minController, TextEditingController secController) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Row(
            children: [
              _buildSingleInput('Deg', degController),
              _buildSingleInput('Min', minController),
              _buildSingleInput('Sec', secController),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSingleInput(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConvertedRow(String label, String value) {
    return Row(
      children: [
        Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text(value)),
      ],
    );
  }
}
