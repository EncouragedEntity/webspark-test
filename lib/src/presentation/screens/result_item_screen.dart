import 'package:flutter/material.dart';
import '../../domain/models/point_model.dart';
import '../../domain/models/result_model.dart';

class ResultItemScreen extends StatelessWidget {
  final ResultModel result;

  const ResultItemScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Shortest Path: ${result.path}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: result.task!.field[0].length,
              ),
              itemCount:
                  result.task!.field.length * result.task!.field[0].length,
              itemBuilder: (context, index) {
                int x = index ~/ result.task!.field[0].length;
                int y = index % result.task!.field[0].length;

                Color color;
                if (x == result.task!.start.x && y == result.task!.start.y) {
                  color = Colors.tealAccent;
                } else if (x == result.task!.end.x && y == result.task!.end.y) {
                  color = Colors.teal;
                } else if (result.task!.field[x][y] == 'X') {
                  color = Colors.black;
                } else if (result.steps.contains(Point(x: x, y: y))) {
                  color = Colors.green;
                } else {
                  color = Colors.white;
                }

                return Container(
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text('($x.$y)'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
