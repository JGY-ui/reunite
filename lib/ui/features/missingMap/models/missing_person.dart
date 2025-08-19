import 'package:json_annotation/json_annotation.dart';

part 'missing_person.g.dart';  // 자동 생성 파일

@JsonSerializable()
class MissingPerson {
  final String? occrde;          // 발생일시
  final String? alldressingDscd; // 착의사항
  final String? ageNow;          // 현재나이
  final int? age;             // 당시나이
  final String? writngTrgetDscd; // 대상구분
  final String? sexdstnDscd;     // 성별
  final String? occrAdres;       // 발생장소
  final String? nm;              // 성명
  final int? msspsnIdntfccd;  // 사진 ID
  final String? etcSpfeatr; // 신체 튿징

  MissingPerson({
    this.occrde,
    this.alldressingDscd,
    this.ageNow,
    this.age,
    this.writngTrgetDscd,
    this.sexdstnDscd,
    this.occrAdres,
    this.nm,
    this.msspsnIdntfccd,
    this.etcSpfeatr,
  });

  // JSON -> 객체
  factory MissingPerson.fromJson(Map<String, dynamic> json) =>
      _$MissingPersonFromJson(json);

  // 객체 -> JSON
  Map<String, dynamic> toJson() => _$MissingPersonToJson(this);
}
