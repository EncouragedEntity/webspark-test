import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'point_model.dart';

part 'result_model.g.dart';

@JsonSerializable()
class ResultModel extends Equatable {
  final List<Point> steps;
  final String path;

  const ResultModel({
    required this.steps,
    required this.path,
  });

  @override
  List<Object?> get props => [path];
}
