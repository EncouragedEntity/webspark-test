import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_model.g.dart';

@JsonSerializable()
class Point extends Equatable {
  final int x;
  final int y;

  const Point({
    required this.x,
    required this.y,
  });

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);

  @override
  List<Object?> get props => [x, y];
}
