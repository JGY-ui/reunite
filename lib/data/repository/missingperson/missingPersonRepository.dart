import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class MissingPersonsRepository {
  Future<List<MissingPerson>> searchMissingPersons({
    required String name,
  });
}
