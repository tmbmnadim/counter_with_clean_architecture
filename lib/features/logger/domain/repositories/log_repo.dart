import 'package:counter_pro/core/resources/data_state.dart';
import 'package:counter_pro/features/logger/logger.dart';

abstract class LogRepo {
  Future<DataState> createLog(Log message);
  Future<DataState<List<Log>>> getLogs();
  Future<DataState> deleteLog(Log log);
  Future<DataState> clearLogs();
}
