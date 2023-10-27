import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_update.g.dart';

@JsonSerializable()
class AppUpdate {
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String image;
  @JsonKey(defaultValue: '')
  final String version;
  @JsonKey(defaultValue: '')
  final String updateType;
  @JsonKey(defaultValue: '')
  final String schemeUrl;
  @JsonKey(defaultValue: 0)
  final int isForceUpdate;

  AppUpdate({
    required this.title,
    required this.image,
    required this.version,
    required this.updateType,
    required this.schemeUrl,
    required this.isForceUpdate,
  });

  factory AppUpdate.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$AppUpdateToJson(this);
}
