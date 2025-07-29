import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:reunite/data/repository/location/locationRepository.dart';
import 'package:reunite/data/service/coding/GeocodingService.dart';
import 'package:reunite/data/service/locater/locaterService.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocaterService locatorService;
  final GeoCodingService codingService;

  LocationRepositoryImpl(
      {required this.locatorService, required this.codingService});

  @override
  Future<Coordinate> getMyCoordinate() => locatorService.getCurrentLocation();

  @override
  Future<Coordinate> getCoordinateFromAddress(String? address) =>
      codingService.getCoordinateFromAddress(address ?? 'Unknown');

  @override
  Future<String> getAddressFromCoordinate(Coordinate? coordinate) =>
      codingService.getAddressFromCoordinate(
          coordinate ?? Coordinate(lat: 0.0, long: 0.0));
}
