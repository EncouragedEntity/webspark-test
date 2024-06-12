import 'dart:collection';

import '../models/point_model.dart';
import '../models/result_model.dart';
import '../models/task_model.dart';

class CalculationService {
  Future<ResultModel?> calculateOne(TaskModel task) async {
    List<String> field = task.field;
    Point start = task.start;
    Point end = task.end;

    int rows = field.length;
    int cols = field[0].length;

    List<Point> directions = [
      const Point(x: 1, y: 0),
      const Point(x: 0, y: 1),
      const Point(x: -1, y: 0),
      const Point(x: 0, y: -1),
      const Point(x: 1, y: 1),
      const Point(x: 1, y: -1),
      const Point(x: -1, y: 1),
      const Point(x: -1, y: -1),
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
