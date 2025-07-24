// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingPerson _$MissingPersonFromJson(Map<String, dynamic> json) =>
    MissingPerson(
      occrde: json['occrde'] as String?,
      alldressingDscd: json['alldressingDscd'] as String?,
      ageNow: json['ageNow'] as String?,
      age: (json['age'] as num?)?.toInt(),
      writngTrgetDscd: json['writngTrgetDscd'] as String?,
      sexdstnDscd: json['sexdstnDscd'] as String?,
      occrAdres: json['occrAdres'] as String?,
      nm: json['nm'] as String?,
      msspsnIdntfccd: (json['msspsnIdntfccd'] as num?)?.toInt(),
      etcSpfeatr: json['etcSpfeatr'] as String?,
    );

Map<String, dynamic> _$MissingPersonToJson(MissingPerson instance) =>
    <String, dynamic>{
      'occrde': instance.occrde,
      'alldressingDscd': instance.alldressingDscd,
      'ageNow': instance.ageNow,
      'age': instance.age,
      'writngTrgetDscd': instance.writngTrgetDscd,
      'sexdstnDscd': instance.sexdstnDscd,
      'occrAdres': instance.occrAdres,
      'nm': instance.nm,
      'msspsnIdntfccd': instance.msspsnIdntfccd,
      'etcSpfeatr': instance.etcSpfeatr,
    };
