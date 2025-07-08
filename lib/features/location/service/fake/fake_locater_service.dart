
import 'package:reunite/features/location/model/model.dart';
import 'package:reunite/features/location/service/locater_service.dart';

class FakeGeoLocaterService implements LocaterService {
  @override
  Future<Coordinate> getCurrentLocation() async {
    return Coordinate(lat: 37.5665851, long: 126.97820379999999);
  }
}