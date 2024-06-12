import 'dart:convert';

import 'package:webspark_test/src/data/repositories/url_repository.dart';
import 'package:webspark_test/src/domain/models/task_model.dart';

import 'package:http/http.dart' as http;
import 'dart:collection';

import '../../domain/models/point_model.dart';
import '../../domain/models/result_model.dart';

class TaskRepository {
  Future<List<TaskModel>?> fetchAll() async {
    final response = await http.get(Uri.parse(UrlRepository.currentUrl));

    if (response.statusCode != 200) return null;

    final responseData = jsonDecode(response.body);
    if (responseData['error']) return null;

    final output = responseData['data']
        .map<TaskModel>((json) => TaskModel.fromJson(json))
        .toList();

    return output;
  }

  void sendAll(List<ResultModel?> results) async {
    List<Map<String, dynamic>> jsonList = results
        .where((result) => result != null)
        .map((result) => result!.toJson())
        .toList();

    String jsonString = jsonEncode(jsonList);

    await http.post(
      Uri.parse(UrlRepository.currentUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );
  }

  Future<ResultModel?> calculateOne(TaskModel task) async {
    List<String> field = task.field;
    Point start = task.start;
    Point end = task.end;

    int rows = field.length;
    int cols = field[0].length;

    List<Point> directions = [
      const Point(x: 1, y: 0), // right
      const Point(x: 0, y: 1), // down
      const Point(x: -1, y: 0), // left
      const Point(x: 0, y: -1), // up
      const Point(x: 1, y: 1), // down-right
      const Point(x: 1, y: -1), // down-left
      const Point(x: -1, y: 1), // up-right
      const Point(x: -1, y: -1), // up-left
    ];

    Queue<List<Point>> queue = Queue();
    Set<Point> visited = {};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      List<Point> path = queue.removeFirst();
      Point last = path.last;

      if (last.x == end.x && last.y == end.y) {
        String pathString = path.map((p) => '(${p.x}.${p.y})').join(' -> ');
        return ResultModel(
            task: task, id: task.id, steps: path, path: pathString);
      }

      for (Point direction in directions) {
        int newX = last.x + direction.x;
        int newY = last.y + direction.y;

        if (newX >= 0 &&
            newX < rows &&
            newY >= 0 &&
            newY < cols &&
            field[newX][newY] != 'X') {
          Point newPoint = Point(x: newX, y: newY);
          if (!visited.contains(newPoint)) {
            visited.add(newPoint);
            List<Point> newPath = List.from(path)..add(newPoint);
            queue.add(newPath);
          }
        }
      }
    }

    return null;
  }
}
