// // import 'package:flutter/material.dart';
// //
// // class CoordinateConverter extends StatefulWidget {
// //   @override
// //   _CoordinateConverterState createState() => _CoordinateConverterState();
// // }
// //
// // class _CoordinateConverterState extends State<CoordinateConverter> {
// //   final TextEditingController latDegController = TextEditingController();
// //   final TextEditingController latMinController = TextEditingController();
// //   final TextEditingController latSecController = TextEditingController();
// //
// //   final TextEditingController lonDegController = TextEditingController();
// //   final TextEditingController lonMinController = TextEditingController();
// //   final TextEditingController lonSecController = TextEditingController();
// //
// //   final TextEditingController altController = TextEditingController();
// //
// //   double convertedLatDegMin = 0.0;
// //   double convertedLonDegMin = 0.0;
// //
// //   double convertedLatDeg = 0.0;
// //   double convertedLonDeg = 0.0;
// //
// //   double easting = 0.0;
// //   double northing = 0.0;
// //   double convertedAlt = 0.0;
// //
// //   void _updateConversions() {
// //     setState(() {
// //       // Convert latitude and longitude from DMS to degrees and minutes
// //       double latDeg = double.tryParse(latDegController.text) ?? 0;
// //       double latMin = double.tryParse(latMinController.text) ?? 0;
// //       double latSec = double.tryParse(latSecController.text) ?? 0;
// //
// //       double lonDeg = double.tryParse(lonDegController.text) ?? 0;
// //       double lonMin = double.tryParse(lonMinController.text) ?? 0;
// //       double lonSec = double.tryParse(lonSecController.text) ?? 0;
// //
// //       double alt = double.tryParse(altController.text) ?? 0;
// //
// //       convertedLatDegMin = latDeg + (latMin / 60) + (latSec / 3600);
// //       convertedLonDegMin = lonDeg + (lonMin / 60) + (lonSec / 3600);
// //
// //       convertedLatDeg = convertedLatDegMin;
// //       convertedLonDeg = convertedLonDegMin;
// //
// //       // Conversion to UTM (Easting, Northing) - using simplified formula
// //       // Note: For real applications, use a proper library for accurate conversion
// //       easting = convertedLonDeg * 111320; // Simplified conversion factor
// //       northing = convertedLatDeg * 110540; // Simplified conversion factor
// //       convertedAlt = alt;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Column(
// //         children: [
// //           // Input fields for Latitude, Longitude and Altitude
// //           Row(
// //             children: [
// //               _buildCoordinateInput('Lat (DMS)', latDegController, latMinController, latSecController),
// //               _buildCoordinateInput('Lon (DMS)', lonDegController, lonMinController, lonSecController),
// //               _buildSingleInput('Alt (m)', altController),
// //             ],
// //           ),
// //           SizedBox(height: 20),
// //           // Display converted values
// //           _buildConvertedRow('Degrees Minutes', '$convertedLatDegMin, $convertedLonDegMin'),
// //           _buildConvertedRow('Degrees', '$convertedLatDeg, $convertedLonDeg'),
// //           _buildConvertedRow('Easting, Northing, Altitude', '$easting, $northing, $convertedAlt'),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCoordinateInput(String label, TextEditingController degController, TextEditingController minController, TextEditingController secController) {
// //     return Expanded(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(label),
// //           Row(
// //             children: [
// //               _buildSingleInput('Deg', degController),
// //               _buildSingleInput('Min', minController),
// //               _buildSingleInput('Sec', secController),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSingleInput(String label, TextEditingController controller) {
// //     return Expanded(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(label),
// //           TextField(
// //             controller: controller,
// //             keyboardType: TextInputType.number,
// //             decoration: InputDecoration(
// //               border: OutlineInputBorder(),
// //             ),
// //             onChanged: (value) => _updateConversions(), // Trigger conversion on input change
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildConvertedRow(String label, String value) {
// //     return Row(
// //       children: [
// //         Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
// //         Expanded(child: Text(value)),
// //       ],
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class CoordinateConverter extends StatefulWidget {
//   @override
//   _CoordinateConverterState createState() => _CoordinateConverterState();
// }
//
// class _CoordinateConverterState extends State<CoordinateConverter> {
//   final TextEditingController latDegController = TextEditingController();
//   final TextEditingController latMinController = TextEditingController();
//   final TextEditingController latSecController = TextEditingController();
//
//   final TextEditingController lonDegController = TextEditingController();
//   final TextEditingController lonMinController = TextEditingController();
//   final TextEditingController lonSecController = TextEditingController();
//
//   final TextEditingController altController = TextEditingController();
//
//   final TextEditingController convertedLatDegMinController = TextEditingController();
//   final TextEditingController convertedLonDegMinController = TextEditingController();
//   final TextEditingController convertedAltController = TextEditingController();
//
//   final TextEditingController convertedLatDegController = TextEditingController();
//   final TextEditingController convertedLonDegController = TextEditingController();
//
//   final TextEditingController eastingController = TextEditingController();
//   final TextEditingController northingController = TextEditingController();
//   final TextEditingController convertedAltEastingNorthingController = TextEditingController();
//
//   void _updateConversions() {
//     setState(() {
//       // Convert latitude and longitude from DMS to degrees and minutes
//       double latDeg = double.tryParse(latDegController.text) ?? 0;
//       double latMin = double.tryParse(latMinController.text) ?? 0;
//       double latSec = double.tryParse(latSecController.text) ?? 0;
//
//       double lonDeg = double.tryParse(lonDegController.text) ?? 0;
//       double lonMin = double.tryParse(lonMinController.text) ?? 0;
//       double lonSec = double.tryParse(lonSecController.text) ?? 0;
//
//       double alt = double.tryParse(altController.text) ?? 0;
//
//       double convertedLatDegMin = latDeg + (latMin / 60);
//       double convertedLonDegMin = lonDeg + (lonMin / 60);
//
//       double convertedLatDeg = latDeg + (latMin / 60) + (latSec / 3600);
//       double convertedLonDeg = lonDeg + (lonMin / 60) + (lonSec / 3600);
//
//       // Conversion to UTM (Easting, Northing) - using simplified formula
//       // Note: For real applications, use a proper library for accurate conversion
//       double easting = convertedLonDeg * 111320; // Simplified conversion factor
//       double northing = convertedLatDeg * 110540; // Simplified conversion factor
//
//       // Update controllers
//       convertedLatDegMinController.text = '${latDeg}° ${latMin}\'';
//       convertedLonDegMinController.text = '${lonDeg}° ${lonMin}\'';
//       convertedAltController.text = '$alt m';
//
//       convertedLatDegController.text = '$convertedLatDeg°';
//       convertedLonDegController.text = '$convertedLonDeg°';
//
//       eastingController.text = '$easting';
//       northingController.text = '$northing';
//       convertedAltEastingNorthingController.text = '$alt';
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize with empty values
//     convertedLatDegMinController.text = '';
//     convertedLonDegMinController.text = '';
//     convertedAltController.text = '';
//
//     convertedLatDegController.text = '';
//     convertedLonDegController.text = '';
//
//     eastingController.text = '';
//     northingController.text = '';
//     convertedAltEastingNorthingController.text = '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Input fields for Latitude, Longitude and Altitude
//           Row(
//             children: [
//               _buildCoordinateInput('Lat (DMS)', latDegController, latMinController, latSecController),
//               _buildCoordinateInput('Lon (DMS)', lonDegController, lonMinController, lonSecController),
//               _buildSingleInput('Alt (m)', altController),
//             ],
//           ),
//           SizedBox(height: 20),
//           // First output row: Degrees Minutes
//           _buildOutputRow(1, 'Lat-Lon-Alt (DM)', convertedLatDegMinController,
//               convertedLonDegMinController, convertedAltController),
//           SizedBox(height: 20),
//           // Second output row: Degrees
//           _buildOutputRow(2, 'Lat-Lon-Alt (D)', convertedLatDegController, convertedLonDegController, convertedAltController),
//           SizedBox(height: 20),
//           // Third output row: Easting, Northing, Altitude
//           _buildOutputRow2(3, 'East-Nort-Alt', eastingController,
//               northingController, convertedAltEastingNorthingController),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCoordinateInput(String label, TextEditingController degController, TextEditingController minController, TextEditingController secController) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           Row(
//             children: [
//               _buildSingleInput('Deg', degController),
//               _buildSingleInput('Min', minController),
//               _buildSingleInput('Sec', secController),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSingleInput(String label, TextEditingController controller) {
//     return Expanded(
//       child: TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: label,
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (value) => _updateConversions(), // Trigger conversion on input change
//           ),
//     );
//   }
//
//   // Widget _buildSingleInput(String label, TextEditingController controller) {
//   //   return TextField(
//   //           controller: controller,
//   //           keyboardType: TextInputType.number,
//   //           decoration: InputDecoration(
//   //             labelText: label,
//   //             border: OutlineInputBorder(),
//   //           ),
//   //           onChanged: (value) => _updateConversions(), // Trigger conversion on input change
//   //   );
//   // }
//
//   Widget _buildOutputRow(int rowNum, String label, TextEditingController latController, TextEditingController lonController, TextEditingController altController) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             SizedBox(width: 12,),
//             SizedBox(
//                 width: 90,
//                 height: 40,
//                 child: _buildNonEditableInput('Latitude', latController)
//             ),
//             SizedBox(width: 12,),
//             SizedBox(
//                 width: 100,
//                 height: 40,
//                 child: _buildNonEditableInput('Longitude', lonController)),
//             SizedBox(width: 12,),
//             SizedBox(
//                 width: 90,
//                 height: 40,
//                 child: _buildNonEditableInput('Altitude', altController)),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildOutputRow2(int rowNum, String label, TextEditingController
//   latController, TextEditingController lonController, TextEditingController altController) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             SizedBox(width: 12,),
//             SizedBox(
//                 width: 90,
//                 height: 40,
//                 child: _buildNonEditableInput('Easting', latController)
//             ),
//             SizedBox(width: 12,),
//             SizedBox(
//                 width: 100,
//                 height: 40,
//                 child: _buildNonEditableInput('Northing', lonController)),
//             SizedBox(width: 12,),
//             SizedBox(
//                 width: 90,
//                 height: 40,
//                 child: _buildNonEditableInput('Altitude', altController)),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNonEditableInput(String label, TextEditingController controller) {
//     return TextField(
//           controller: controller,
//           readOnly: true,
//           decoration: InputDecoration(
//             labelText: label,
//             border: OutlineInputBorder(),
//           ),
//     );
//   }
// }



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

  final TextEditingController convertedLatDegMinController = TextEditingController();
  final TextEditingController convertedLonDegMinController = TextEditingController();
  final TextEditingController convertedAltController = TextEditingController();

  final TextEditingController convertedLatDegController = TextEditingController();
  final TextEditingController convertedLonDegController = TextEditingController();

  final TextEditingController eastingController = TextEditingController();
  final TextEditingController northingController = TextEditingController();
  final TextEditingController convertedAltEastingNorthingController = TextEditingController();

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

      double convertedLatDegMin = latDeg + (latMin / 60);
      double convertedLonDegMin = lonDeg + (lonMin / 60);

      double convertedLatDeg = latDeg + (latMin / 60) + (latSec / 3600);
      double convertedLonDeg = lonDeg + (lonMin / 60) + (lonSec / 3600);

      // Conversion to UTM (Easting, Northing) - using simplified formula
      // Note: For real applications, use a proper library for accurate conversion
      double easting = convertedLonDeg * 111320; // Simplified conversion factor
      double northing = convertedLatDeg * 110540; // Simplified conversion factor

      // Update controllers
      convertedLatDegMinController.text = '${latDeg}° ${latMin}\'';
      convertedLonDegMinController.text = '${lonDeg}° ${lonMin}\'';
      convertedAltController.text = '$alt m';

      convertedLatDegController.text = '$convertedLatDeg°';
      convertedLonDegController.text = '$convertedLonDeg°';

      eastingController.text = '$easting';
      northingController.text = '$northing';
      convertedAltEastingNorthingController.text = '$alt';
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize with empty values
    convertedLatDegMinController.text = '';
    convertedLonDegMinController.text = '';
    convertedAltController.text = '';

    convertedLatDegController.text = '';
    convertedLonDegController.text = '';

    eastingController.text = '';
    northingController.text = '';
    convertedAltEastingNorthingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // Input row: Degrees, Minutes, Seconds
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: _buildInputRow(0, 'Lat-Lon-Alt (DMS)', latDegController, latMinController, latSecController, lonDegController, lonMinController, lonSecController, altController),
          ),
          SizedBox(height: 8),
          // First output row: Degrees Minutes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildOutputRow(1, 'Lat-Lon-Alt (DM)', convertedLatDegMinController, convertedLonDegMinController, convertedAltController),
          ),
          SizedBox(height: 8),
          // Second output row: Degrees
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildOutputRow(2, 'Lat-Lon-Alt (D)', convertedLatDegController, convertedLonDegController, convertedAltController),
          ),
          SizedBox(height: 8),
          // Third output row: Easting, Northing, Altitude
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildOutputRow(3, 'East-Nort-Alt', eastingController, northingController, convertedAltEastingNorthingController),
          ),
        ],
    );
  }

  Widget _buildInputRow(int rowNum, String label, TextEditingController latDegController, TextEditingController latMinController, TextEditingController latSecController, TextEditingController lonDegController, TextEditingController lonMinController, TextEditingController lonSecController, TextEditingController altController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 8,),
            Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            SizedBox(width: 45, height: 40, child: _buildEditableInput(
                'DD', latDegController)),
            SizedBox(width: 4),
            SizedBox(width: 45, height: 40, child: _buildEditableInput(
                'MM', latMinController)),
            SizedBox(width: 4),
            SizedBox(width: 45, height: 40, child: _buildEditableInput(
                'SS', latSecController)),
            SizedBox(width: 4),
            SizedBox(width: 45, height: 40, child: _buildEditableInput(
                'DD', lonDegController)),
            SizedBox(width: 4),
            SizedBox(width: 45, height: 40, child: _buildEditableInput(
                'MM', lonMinController)),
            SizedBox(width: 4),
            SizedBox(width: 45, height: 40, child: _buildEditableInput(
                'SS', lonSecController)),
            SizedBox(width: 4),
            SizedBox(width: 45, height: 40, child: _buildEditableInput('Alt',
                altController)),
          ],
        ),
      ],
    );
  }

  Widget _buildEditableInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 12),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => _updateConversions(), // Trigger conversion on input change
    );
  }

  Widget _buildOutputRow(int rowNum, String label, TextEditingController latController, TextEditingController lonController, TextEditingController altController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Row(
          children: [
            SizedBox(width: 12),
            SizedBox(width: 90, height: 40, child: _buildNonEditableInput('Latitude', latController)),
            SizedBox(width: 12),
            SizedBox(width: 100, height: 40, child: _buildNonEditableInput('Longitude', lonController)),
            SizedBox(width: 12),
            SizedBox(width: 90, height: 40, child: _buildNonEditableInput('Altitude', altController)),
          ],
        ),
      ],
    );
  }

  Widget _buildNonEditableInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
