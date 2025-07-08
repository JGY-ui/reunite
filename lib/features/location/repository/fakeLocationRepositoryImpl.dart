import 'package:reunite/features/location/model/model.dart';
import 'package:reunite/features/location/repository/location_repository.dart';
import 'package:reunite/features/location/service/coding_service.dart';
import 'package:reunite/features/location/service/locater_service.dart';

class FakeLocationRepositoryImpl implements LocationRepository {
  final LocaterService locatorService;
  final CodingService codingService;

  FakeLocationRepositoryImpl({required this.locatorService, required this.codingService});

  @override
  Future<Coordinate> getMyCoordinate() => locatorService.getCurrentLocation();

  @override
  Future<Coordinate> getCoordinateFromAddress(String? address) => codingService.getCoordinateFromAddress('서울특별시 중구 세종대로 110');

  @override
  Future<String> getAddressFromCoordinate(Coordinate? coordinate) => codingService.getAddressFromCoordinate(Coordinate(lat: 37.5665851, long: 126.97820379999999));
}