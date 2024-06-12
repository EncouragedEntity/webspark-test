import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/src/data/repositories/url_repository.dart';
import 'package:webspark_test/src/presentation/screens/processing_screen.dart';
import 'package:webspark_test/src/utils/validators/text_input_validators.dart';

import 'cubits/counter/counter_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController =
      TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');

  Future<int> onFormSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return HttpStatus.internalServerError;
    }

    await UrlRepository().setUrl(_urlController.text);

    return HttpStatus.ok;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Text('Set valid API base URL in order to continue'),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.compare_arrows, color: Colors.grey),
                const SizedBox(width: 36),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _urlController,
                      validator: TextInputValidators.urlFormatter,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('Start counting process'),
              onPressed: () async {
                final response = await onFormSubmit();

                if (response == HttpStatus.ok && context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CounterCubit(),
                        child: const ProcessingScreen(),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
