import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reunite/data/service/missingPersons/missingPersonsService.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class FakeMissingPersonListServiceImpl implements MissingPersonsService {
  @override
  Future<List<MissingPerson>> loadMissingPersons({
    required String address,
  }) async {
    return [];
  }
}
