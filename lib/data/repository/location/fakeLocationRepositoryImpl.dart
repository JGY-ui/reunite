import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/repository/location/locationRepository.dart';
import 'package:reunite/data/service/coding/GeocodingService.dart';
import 'package:reunite/data/service/locater/locaterService.dart';

class FakeLocationRepositoryImpl implements LocationRepository {
  final LocaterService locatorService;
  final GeoCodingService codingService;

  FakeLocationRepositoryImpl(
      {required this.locatorService, required this.codingService});

  @override
  Future<Coordinate> getMyCoordinate() => locatorService.getCurrentLocation();

  @override
  Future<Coordinate> getCoordinateFromAddress(String? address) =>
      codingService.getCoordinateFromAddress('서울특별시 중구 세종대로 110');

  @override
  Future<String> getAddressFromCoordinate(Coordinate? coordinate) =>
      codingService.getAddressFromCoordinate(
          Coordinate(lat: 37.5665851, long: 126.97820379999999));
}
