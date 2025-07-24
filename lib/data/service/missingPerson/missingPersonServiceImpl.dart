import 'dart:convert';

import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'package:http/http.dart' as http;
import 'missingPersonService.dart';

class MissingPersonServiceImpl implements MissingPersonService {
  static const String baseUrl =
      'https://www.safe182.go.kr/api/lcm/findChildList.do';
  static const String esntlId = '10000756';
  static const String authKey = '2236b804d7b34428';

  @override
  Future<List<MissingPerson>> searchMissingPersons({
    required String name,
  }) async {
    final params = {
      'esntlId': esntlId,
      'authKey': authKey,
      'rowSize': '100',
      // 'page': '2',
      // 'writngTrgetDscds': '010',
      'nm': name
    };

    //윤지섭, 강다은, 정온성, 권춘단

    final uri = Uri.parse(baseUrl).replace(queryParameters: params);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['list'] is List) {
        final list = data['list'] as List;

        return list.map((e) => MissingPerson.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Failed to load missing persons, status code: ${response.statusCode}');
    }
  }
}
