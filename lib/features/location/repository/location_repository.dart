
import 'package:reunite/features/location/model/model.dart';

abstract class LocationRepository {
  Future<Coordinate> getMyCoordinate();
  Future<Coordinate> getCoordinateFromAddress(String? address);
  Future<String> getAddressFromCoordinate(Coordinate? coordinate);
}