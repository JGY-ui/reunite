import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class GeoCodingService {
  Future<Coordinate> getCoordinateFromAddress(String address);
  Future<String> getAddressFromCoordinate(Coordinate coordinate);
}
