import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/service/locater/locaterService.dart';

class FakeGeoLocaterServiceImpl implements LocaterService {
  @override
  Future<Coordinate> getCurrentLocation() async {
    return Coordinate(lat: 37.5665851, long: 126.97820379999999);
  }
}
