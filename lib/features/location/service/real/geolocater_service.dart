
import 'package:geolocator/geolocator.dart';
import 'package:reunite/features/location/model/model.dart';
import '../locater_service.dart';

class GeoLocaterService implements LocaterService {
  @override
  Future<Coordinate> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return Coordinate(lat: position.latitude, long: position.longitude);
  }
}