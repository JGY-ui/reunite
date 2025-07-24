import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class MissingPersonService {
  Future<List<MissingPerson>> searchMissingPersons({
    required String name,
  });
}
