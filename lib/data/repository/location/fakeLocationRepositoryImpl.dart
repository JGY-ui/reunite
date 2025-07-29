import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/repository/location/locationRepository.dart';
import 'package:reunite/data/service/coding/GeocodingService.dart';
import 'package:reunite/data/service/locater/locaterService.dart';

class FakeLocationRepositoryImpl implements LocationRepository {

  FakeLocationRepositoryImpl();

  @override
  Future<Coordinate> getMyCoordinate() async => Coordinate(lat: 37.5665851, long: 126.97820379999999)

  @override
  Future<Coordinate> getCoordinateFromAddress (String? address) async =>
      Coordinate(lat: 37.5665851, long: 126.97820379999999);

  @override
  Future<String> getAddressFromCoordinate(Coordinate? coordinate) async => 
      '서울특별시 중구 세종대로 110';
}
