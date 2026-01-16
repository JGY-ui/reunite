import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reunite/data/service/missingPersons/missingPersonsService.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';
import 'missingPersonRepository.dart';

class MissingPersonRepositoryImpl implements MissingPersonRepository {
  final MissingPersonsService _service;

  MissingPersonRepositoryImpl({required MissingPersonsService service})
      : _service = service;

  @override
  Future<List<MissingPerson>> loadMissingPersons(
      {required String address}) async {
    if (address.trim().isEmpty) {
      // 필요 시: 빈 검색어일 때 Remote 호출 대신 바로 빈 리스트 반환하거나
      // 초기 목록 API를 따로 호출하도록 분기 가능
      return [];
    }

    try {
      final result = await _service.loadMissingPersons(address: address.trim());
      // 여기서 DTO -> Domain 변환 / 정렬 / 필터링 / 캐싱 등의 후처리 가능
      return result;
    } catch (e) {
      // 에러 타입 매핑, 로깅, 재시도 정책 등을 여기서 처리
      rethrow; // 단순 전달
    }
  }
}
