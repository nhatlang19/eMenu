// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Section',
      json,
      ($checkedConvert) {
        final val = Section(
          section: $checkedConvert('Section', (v) => v as String),
          description1: $checkedConvert('Description1', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'section': 'Section', 'description1': 'Description1'},
    );
