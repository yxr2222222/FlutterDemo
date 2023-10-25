// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdate _$AppUpdateFromJson(Map<String, dynamic> json) => AppUpdate(
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      version: json['version'] as String? ?? '',
      updateType: json['updateType'] as String? ?? '',
      schemeUrl: json['schemeUrl'] as String? ?? '',
      isForceUpdate: json['isForceUpdate'] as int? ?? 0,
    );

Map<String, dynamic> _$AppUpdateToJson(AppUpdate instance) => <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'version': instance.version,
      'updateType': instance.updateType,
      'schemeUrl': instance.schemeUrl,
      'isForceUpdate': instance.isForceUpdate,
    };
