import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class LocaterService {
  Future<Coordinate> getCurrentLocation();
}
