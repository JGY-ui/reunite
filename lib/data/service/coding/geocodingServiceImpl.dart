import 'package:geocoding/geocoding.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/service/coding/codingService.dart';

class GeoCodingServiceImpl implements CodingService {
  @override
  Future<Coordinate> getCoordinateFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return Coordinate(
        lat: locations.first.latitude, long: locations.first.longitude);
  }

  @override
  Future<String> getAddressFromCoordinate(Coordinate coordinate) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(coordinate.lat, coordinate.long);
    return placemarks.first.street ?? 'Unknown';
  }
}
