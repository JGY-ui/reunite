import 'package:geocoding/geocoding.dart';
import 'package:reunite/features/location/model/model.dart';
import 'package:reunite/features/location/service/coding_service.dart';

class GeoCodingService implements CodingService {
  @override
  Future<Coordinate> getCoordinateFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return Coordinate(lat: locations.first.latitude, long: locations.first.longitude);
  }

  @override
  Future<String> getAddressFromCoordinate(Coordinate coordinate) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(coordinate.lat, coordinate.long);
    return placemarks.first.street ?? 'Unknown';
  }
}