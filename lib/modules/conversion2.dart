import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arnv/pages/dropdownENA.dart';

class ENACoordinateConverter extends StatefulWidget {
  @override
  _ENACoordinateConverterState createState() => _ENACoordinateConverterState();
}

class _ENACoordinateConverterState extends State<ENACoordinateConverter> {
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController eastingController = TextEditingController();
  final TextEditingController northingController = TextEditingController();
  final TextEditingController altitudeController = TextEditingController();

  final TextEditingController convertedLatDMS = TextEditingController();
  final TextEditingController convertedLatDM = TextEditingController();
  final TextEditingController convertedLatD = TextEditingController();

  final TextEditingController convertedLonDMS = TextEditingController();
  final TextEditingController convertedLonDM = TextEditingController();
  final TextEditingController convertedLonD = TextEditingController();

  void _updateConversions() {
    setState(() {
      // Get values from controllers
      double zone = double.tryParse(zoneController.text) ?? 0;
      double easting = double.tryParse(eastingController.text) ?? 0;
      double northing = double.tryParse(northingController.text) ?? 0;
      double altitude = double.tryParse(altitudeController.text) ?? 0;

      // THESE ARE DUMMY CONVERSIONS AND WILL BE DONE BASED LATER BASED ON THE
      // CALCULATION.DART FILE
      convertedLatDMS.text = '${zone}° ${easting}\'';
      convertedLonDMS.text= '${zone}° ${northing}\'';
      convertedLatDM.text = '${zone}° ${easting}\'';
      convertedLonDM.text= '${zone}° ${northing}\'';
      convertedLatD.text = '${zone}.${easting}${northing}°';
      convertedLonD.text = '${zone}.${easting}${northing}°';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          // Input Row
          Row(
            children: [
              Text('East-Nort-Alt', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [
              DropdownMenuExample(),
              // SizedBox(width: 5),
              SizedBox(
                width: 90,
                height: 40,
                child: TextField(
                  controller: eastingController,
                  decoration: InputDecoration(
                    labelText: 'Easting',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _updateConversions(),
                ),
              ),
              SizedBox(width: 6),
              SizedBox(
                width: 90,
                height: 40,
                child: TextField(
                  controller: northingController,
                  decoration: InputDecoration(
                    labelText: 'Northing',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _updateConversions(),
                ),
              ),
              SizedBox(width: 6),
              SizedBox(
                width: 90,
                height: 40,
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
          SizedBox(height: 8),
          // Output Rows
          _buildOutputRow('Lat-Lon-Alt (DMS)', convertedLatDMS, convertedLonDMS, altitudeController),
          SizedBox(height: 8),
          _buildOutputRow('Lat-Lon-Alt (DM)', convertedLatDM, convertedLonDM, altitudeController),
          SizedBox(height: 8),
          _buildOutputRow('Lat-Lon-Alt (D)', convertedLatD, convertedLonD, altitudeController),
        ],
      ),
    );
  }

  Widget _buildOutputRow(String label, TextEditingController latController, TextEditingController lonController, [TextEditingController? altController]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Row(
          children: [
            SizedBox(width: 30),
            SizedBox(
              width: 90,
              height: 40,
              child: TextField(
                controller: latController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 6),
            SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                controller: lonController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 6),
            SizedBox(
              width: 90,
              height: 40,
              child: TextField(
                controller: altController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Altitude',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
