import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/src/data/repositories/task_repository.dart';
import 'package:webspark_test/src/domain/models/result_model.dart';

import '../../../../domain/models/task_model.dart';
import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  final TaskRepository _repo = TaskRepository();

  Future<void> fetchTasks() async {
    emit(CounterFetching());
    final tasks = await _repo.fetchAll() ?? [];
    emit(CounterFetched(tasks: tasks));
  }

  Future<void> calculatePath(List<TaskModel> tasks) async {
    emit(CounterCalculating(progress: 0));
    final List<ResultModel?> results = [];
    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      final result = await _repo.calculateOne(task);
      results.add(result);
      await Future.delayed(const Duration(seconds: 1));
      emit(CounterCalculated(progress: (i + 1) / tasks.length));
    }
    emit(CounterCalculated(results: results, progress: 1));
  }

  Future<void> sendResults(List<ResultModel?> results) async {
    _repo.sendAll(results);
    emit(CounterSent(results: results));
  }
}
