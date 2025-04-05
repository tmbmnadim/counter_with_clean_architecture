import 'package:counter_pro/features/counter/counter.dart';
import 'package:get_it/get_it.dart';

final counterDI = GetIt.instance;

class CounterDependencies {
  static void init() {
    counterDI.registerFactory<CounterBloc>(() => CounterBloc());
  }
}
