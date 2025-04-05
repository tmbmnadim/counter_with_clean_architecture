import 'package:counter_pro/dependency_injector.dart';
import 'package:counter_pro/features/counter/presentation/pages/counter_view.dart';
import 'package:counter_pro/features/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/counter/presentation/bloc/counter_bloc.dart';

void main() {
  Dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (_) => di<CounterBloc>(),
        ),
        BlocProvider(
          create: (_) => di<LoggerCubit>()..loadLogs(),
        )
      ],
      child: MaterialApp(
        title: 'Counter Pro',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CounterView(),
      ),
    );
  }
}
