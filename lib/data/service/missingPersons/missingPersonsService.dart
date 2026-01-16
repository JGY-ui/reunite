import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class MissingPersonsService {
  Future<List<MissingPerson>> loadMissingPersons({required String address});
}
