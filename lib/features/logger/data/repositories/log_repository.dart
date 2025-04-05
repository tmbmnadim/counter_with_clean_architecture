import 'package:counter_pro/core/resources/data_state.dart';
import 'package:counter_pro/features/logger/data/datasources/log_source_local.dart';
import 'package:counter_pro/features/logger/data/models/log_model.dart';
import 'package:counter_pro/features/logger/logger.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repositories/log_repo.dart';

class LogRepository implements LogRepo {
  final LogManager _logManager;
  LogRepository(this._logManager);

  @override
  Future<DataState> createLog(Log log) async {
    try {
      final logModel = LogModel.fromEntity(log);
      await _logManager.addLog(logModel);
      return const DataSuccess(null);
    } catch (e) {
      return ErrorOccured(e.toString());
    }
  }

  @override
  Future<DataState<List<Log>>> getLogs() async {
    try {
      final logdata = await _logManager.getLogs();

      return DataSuccess(logdata);
    } catch (e) {
      return ErrorOccured(e.toString());
    }
  }

  @override
  Future<DataState> deleteLog(Log log) async {
    try {
      await _logManager.deleteLog(LogModel.fromEntity(log));
      return const DataSuccess(null);
    } catch (e) {
      return ErrorOccured(e.toString());
    }
  }

  @override
  Future<DataState> clearLogs() async {
    try {
      await _logManager.clearLogs();
      return const DataSuccess(null);
    } catch (e) {
      return ErrorOccured(e.toString());
    }
  }
}
