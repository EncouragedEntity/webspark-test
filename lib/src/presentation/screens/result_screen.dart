import 'package:flutter/material.dart';
import 'package:webspark_test/src/domain/models/result_model.dart';
import 'package:webspark_test/src/presentation/screens/result_item_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.list});

  final List<ResultModel?> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(list[index]!.path),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ResultItemScreen(
                result: list[index]!,
              ),
            ));
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
