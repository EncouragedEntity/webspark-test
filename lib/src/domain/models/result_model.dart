import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webspark_test/src/domain/models/task_model.dart';

import 'point_model.dart';

part 'result_model.g.dart';

@JsonSerializable()
class ResultModel extends Equatable {
  final String id;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TaskModel? task;
  final List<Point> steps;
  final String path;

  const ResultModel({
    this.task,
    required this.id,
    required this.steps,
    required this.path,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResultModelToJson(this);

  @override
  List<Object?> get props => [path];
}
