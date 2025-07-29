import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/service/coding/GeocodingService.dart';

class FakeGeoGeoCodingServiceImpl implements GeoCodingService {
  @override
  Future<Coordinate> getCoordinateFromAddress(String address) async {
    return Coordinate(lat: 37.5665851, long: 126.97820379999999);
  }

  @override
  Future<String> getAddressFromCoordinate(Coordinate coordinate) async {
    return '서울특별시 중구 세종대로 110';
  }
}
