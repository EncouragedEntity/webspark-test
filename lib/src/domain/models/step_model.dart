import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'point_model.dart';

part 'step_model.g.dart';

@JsonSerializable()
class StepModel extends Equatable {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  const StepModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) =>
      _$StepModelFromJson(json);
  Map<String, dynamic> toJson() => _$StepModelToJson(this);

  @override
  List<Object?> get props => [id];
}
