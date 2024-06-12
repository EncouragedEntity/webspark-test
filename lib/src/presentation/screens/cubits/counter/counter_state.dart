import 'package:equatable/equatable.dart';
import 'package:webspark_test/src/domain/models/result_model.dart';

import '../../../../domain/models/task_model.dart';

abstract class CounterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CounterInitial extends CounterState {}

class CounterFetching extends CounterState {}

class CounterSent extends CounterState {
  final List<ResultModel?>? results;

  CounterSent({required this.results});
  @override
  List<Object?> get props => [results];
}

class CounterFetched extends CounterState {
  final List<TaskModel> tasks;

  CounterFetched({required this.tasks});
  @override
  List<Object?> get props => [...tasks];
}

class CounterCalculating extends CounterState {
  final double progress;

  CounterCalculating({required this.progress});
  @override
  List<Object?> get props => [progress];
}

class CounterCalculated extends CounterCalculating {
  final List<ResultModel?>? results;
  CounterCalculated({this.results, super.progress = 1});
  @override
  List<Object?> get props => [results, progress];
}

class CounterError extends CounterState {
  final String message;

  CounterError({required this.message});
  @override
  List<Object?> get props => [message];
}
