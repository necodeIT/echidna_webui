// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_sdk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientSdkImpl _$$ClientSdkImplFromJson(Map<String, dynamic> json) =>
    _$ClientSdkImpl(
      name: json['name'] as String,
      framework: $enumDecode(_$ClientSdkFrameworkEnumMap, json['framework']),
      guides: Map<String, String>.from(json['gettingStarted'] as Map),
    );

Map<String, dynamic> _$$ClientSdkImplToJson(_$ClientSdkImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'framework': _$ClientSdkFrameworkEnumMap[instance.framework]!,
      'gettingStarted': instance.guides,
    };

const _$ClientSdkFrameworkEnumMap = {
  ClientSdkFramework.react: 'react',
  ClientSdkFramework.flutter: 'flutter',
  ClientSdkFramework.dart: 'dart',
  ClientSdkFramework.angular: 'angular',
  ClientSdkFramework.vue: 'vue',
  ClientSdkFramework.svelte: 'svelte',
  ClientSdkFramework.vanillaJS: 'vanillaJS',
};
