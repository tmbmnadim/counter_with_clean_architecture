import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_pro/features/counter/counter.dart';
import 'package:counter_pro/features/logger/logger.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Counter Pro"),
      ),
      body: BlocBuilder<CounterBloc, int>(builder: (context, countState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                countState.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context)
                      .add(CounterIncrementPressed());

                  BlocProvider.of<LoggerCubit>(context).createLog(Log(
                    title: 'Counter Incremented',
                    subtitle:
                        'Current count: $countState\nNew count: ${countState + 1}',
                    createdAt: DateTime.now(),
                  ));
                },
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context)
                      .add(CounterDecrementPressed());

                  BlocProvider.of<LoggerCubit>(context).createLog(Log(
                    title: 'Counter Decremented',
                    subtitle:
                        'Current count: $countState\nNew count: ${countState - 1}',
                    createdAt: DateTime.now(),
                  ));
                },
                child: const Text('Decrement'),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoggerPage();
              },
            ),
          );
        },
        tooltip: 'See Logs',
        child: const Icon(Icons.description),
      ),
    );
  }
}
