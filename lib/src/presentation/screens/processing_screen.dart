import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/src/presentation/screens/cubits/counter/counter_cubit.dart';
import 'package:webspark_test/src/presentation/screens/cubits/counter/counter_state.dart';
import 'package:webspark_test/src/presentation/screens/result_screen.dart';
import 'package:webspark_test/src/presentation/widgets/loader.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process screen')),
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (ctx, state) async {
          if (state is CounterFetched) {
            await context.read<CounterCubit>().calculatePath(state.tasks);
          }
          if (state is CounterSent && context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ResultsScreen(list: state.results!),
              ),
            );
          }
        },
        builder: (ctx, state) {
          if (state is CounterError) {
            return Center(child: Text(state.message));
          }
          if (state is CounterInitial) {
            context.read<CounterCubit>().fetchTasks();
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Data is being fetched'),
                  Loader(),
                ],
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              if (state is CounterCalculated && state.progress == 1)
                const Text(
                  'All calculations has finished, you can send your results to server',
                  textAlign: TextAlign.center,
                ),
              if (state is CounterCalculating)
                Center(
                  child: Column(
                    children: [
                      if (state.progress != 1) const Text('Calculating'),
                      const SizedBox(height: 12),
                      Text('${state.progress * 100}%'),
                      Loader(value: state.progress),
                    ],
                  ),
                ),
              if (state is CounterCalculated) ...[
                const Spacer(),
                ElevatedButton(
                  onPressed: state.progress == 1
                      ? () {
                          if (state.results != null) {
                            context
                                .read<CounterCubit>()
                                .sendResults(state.results!);
                          }
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey;
                      }
                      return Colors.blue;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.black38;
                      }
                      return Colors.white;
                    }),
                    overlayColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.blueAccent;
                      }
                      return Colors.transparent;
                    }),
                  ),
                  child: const Text('Send results to server'),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
