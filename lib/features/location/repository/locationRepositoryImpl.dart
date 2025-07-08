import 'package:reunite/features/location/model/model.dart';
import 'package:reunite/features/location/repository/location_repository.dart';
import 'package:reunite/features/location/service/coding_service.dart';
import 'package:reunite/features/location/service/locater_service.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocaterService locatorService;
  final CodingService codingService;

  LocationRepositoryImpl({required this.locatorService, required this.codingService});

  @override
  Future<Coordinate> getMyCoordinate() => locatorService.getCurrentLocation();

  @override
  Future<Coordinate> getCoordinateFromAddress(String? address) => codingService.getCoordinateFromAddress(address ?? 'Unknown');

  @override
  Future<String> getAddressFromCoordinate(Coordinate? coordinate) => codingService.getAddressFromCoordinate(coordinate ?? Coordinate(lat: 0.0, long: 0.0));
}