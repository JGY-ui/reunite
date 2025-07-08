import 'package:reunite/features/location/model/model.dart';

abstract class CodingService {
  Future<Coordinate> getCoordinateFromAddress(String address);
  Future<String> getAddressFromCoordinate(Coordinate coordinate);
}