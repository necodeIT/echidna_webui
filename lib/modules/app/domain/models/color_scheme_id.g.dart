// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_scheme_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ColorSchemeSerializationImpl _$$ColorSchemeSerializationImplFromJson(
        Map<String, dynamic> json) =>
    _$ColorSchemeSerializationImpl(
      id: $enumDecode(_$ColorSchemeIdEnumMap, json['id']),
    );

Map<String, dynamic> _$$ColorSchemeSerializationImplToJson(
        _$ColorSchemeSerializationImpl instance) =>
    <String, dynamic>{
      'id': _$ColorSchemeIdEnumMap[instance.id]!,
    };

const _$ColorSchemeIdEnumMap = {
  ColorSchemeId.zinc: 'zinc',
  ColorSchemeId.slate: 'slate',
  ColorSchemeId.rose: 'rose',
  ColorSchemeId.blue: 'blue',
  ColorSchemeId.green: 'green',
  ColorSchemeId.orange: 'orange',
  ColorSchemeId.yellow: 'yellow',
  ColorSchemeId.violet: 'violet',
  ColorSchemeId.gray: 'gray',
  ColorSchemeId.neutral: 'neutral',
  ColorSchemeId.red: 'red',
  ColorSchemeId.stone: 'stone',
};
