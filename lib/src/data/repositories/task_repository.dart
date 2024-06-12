import 'dart:convert';

import 'package:webspark_test/src/data/repositories/url_repository.dart';
import 'package:webspark_test/src/domain/models/task_model.dart';

import 'package:http/http.dart' as http;

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
}
