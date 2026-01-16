import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reunite/data/service/missingPersons/missingPersonsService.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class FakeMissingPersonsServiceImpl implements MissingPersonsService {
  final fakeMissingPersons = [
    MissingPerson(
      occrde: "2022-11-03 09:15",
      alldressingDscd: "검은색 점퍼, 회색 바지",
      ageNow: "45",
      age: 43,
      writngTrgetDscd: "성인",
      sexdstnDscd: "여성",
      occrAdres: "부산광역시 해운대구 우동",
      nm: "김영희",
      msspsnIdntfccd: 201,
      etcSpfeatr: "안경 착용",
    ),
    MissingPerson(
      occrde: "2021-07-18 17:00",
      alldressingDscd: "하얀색 원피스",
      ageNow: "10",
      age: 7,
      writngTrgetDscd: "아동",
      sexdstnDscd: "여성",
      occrAdres: "대구광역시 달서구 용산동",
      nm: "박지은",
      msspsnIdntfccd: 305,
      etcSpfeatr: "앞니 빠짐",
    ),
    MissingPerson(
      occrde: "2020-02-25 12:00",
      alldressingDscd: "군용 점퍼, 검은 바지",
      ageNow: "71",
      age: 66,
      writngTrgetDscd: "노인",
      sexdstnDscd: "남성",
      occrAdres: "인천광역시 남동구 논현동",
      nm: "이철수",
      msspsnIdntfccd: 412,
      etcSpfeatr: "치매 증세",
    ),
  ];

  @override
  Future<List<MissingPerson>> loadMissingPersons({
    required String address,
  }) async {
    return fakeMissingPersons;
  }
}
