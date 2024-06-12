import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'point_model.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Equatable {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  const TaskModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  @override
  List<Object?> get props => [id];
}
