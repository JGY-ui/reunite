import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class MissingPersonRepository {
  Future<List<MissingPerson>> loadMissingPersons({
    required String address,
  });
}
