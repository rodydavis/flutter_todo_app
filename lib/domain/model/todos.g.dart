// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todos _$$_TodosFromJson(Map<String, dynamic> json) => _$_Todos(
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TodosToJson(_$_Todos instance) => <String, dynamic>{
      'values': instance.values,
    };
