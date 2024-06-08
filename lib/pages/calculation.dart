import 'dart:math';

class Calculator {
  // Library file for all calculations

  Map<String, String> calculateZone(double latitudePoint, double longitudePoint) {
    String zone = ((latitudePoint * longitudePoint + 5) ?? 0.0).toString();
    return {'zone': zone};
  }

  // Function to calculate bearing between 2 points with primary units being in Lat-Lon-Alt
  Map<String, double> calculateMapBearing(double latA, double lonA, double latB, double lonB) {
    double bearing;
    if( (latB-latA == 0.0) && (lonB-lonA == 0.0) ){
      bearing = atan2(latB-latA, lonB-lonA) * (180.0/pi) ;
    } else if ( (latB-latA < 0.0) && (lonB-lonA >= 0.0) ){
      bearing = 450.0 - atan2(latB-latA, lonB-lonA) * (180.0/pi) ;
    } else {
      bearing = 90.0 - atan2(latB-latA, lonB-lonA) * (180.0/pi) ;
    }
    return {'bearing': bearing};
  }

  Map<String, double> calculateENA(double latitudePoint, double longitudePoint) {
    double easting = latitudePoint + longitudePoint;
    double northing = latitudePoint * longitudePoint;
    return {'easting': easting, 'northing': northing};
  }

  // Function to calculate distance between 2 points with primary units being in Lat-Lon-Alt
  Map<String, double> calculateDistanceLatLonAlt(double latA, double lonA, double altA, double latB, double lonB, double altB) {
    double dLat = pow((latA - latB), 2).toDouble();
    num dLon = pow((lonA - lonB), 2).toDouble();
    num dAlt = pow((altA - altB), 2).toDouble();
    double distance = sqrt(dLat + dLon + dAlt);
    return {'distance': distance};
  }
}