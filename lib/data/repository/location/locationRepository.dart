import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class LocationRepository {
  Future<Coordinate> getMyCoordinate();
  Future<Coordinate> getCoordinateFromAddress(String? address);
  Future<String> getAddressFromCoordinate(Coordinate? coordinate);
}
