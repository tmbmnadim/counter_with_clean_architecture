import 'package:get_it/get_it.dart';

import 'features/logger/loger_dependency.dart';
import 'features/counter/counter_dependency.dart';

final di = GetIt.instance;

class Dependencies {
  static void init() {
    LoggerDependencies.init();
    CounterDependencies.init();
  }
}
