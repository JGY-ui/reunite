
import 'package:reunite/features/location/model/model.dart';

abstract class LocaterService {
  Future<Coordinate> getCurrentLocation();
}