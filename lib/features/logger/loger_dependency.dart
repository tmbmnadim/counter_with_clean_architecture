import 'package:counter_pro/features/logger/logger.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/log_source_local.dart';
import 'data/repositories/log_repository.dart';
import 'domain/repositories/log_repo.dart';

final loggerDI = GetIt.instance;

class LoggerDependencies {
  static void init() {
    loggerDI.registerFactory<LogManager>(() => LogManager());
    loggerDI.registerLazySingleton<LogRepo>(() => LogRepository(loggerDI()));
    loggerDI.registerLazySingleton<LoggerCubit>(() => LoggerCubit(loggerDI()));
  }
}
