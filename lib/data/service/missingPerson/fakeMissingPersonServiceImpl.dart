import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'missingPersonService.dart';

class FakeMissingPersonListServiceImpl implements MissingPersonService {
  Future<List<MissingPerson>> searchMissingPersons({
    required String name,
  }) async {
    return [];
  }
}
