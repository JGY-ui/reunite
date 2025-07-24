import 'package:geolocator/geolocator.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/service/locater/locaterService.dart';

class LocaterServiceImpl implements LocaterService {
  @override
  Future<Coordinate> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return Coordinate(lat: position.latitude, long: position.longitude);
  }
}
