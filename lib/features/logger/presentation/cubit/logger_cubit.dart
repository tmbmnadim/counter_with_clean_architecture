import 'package:counter_pro/core/resources/data_state.dart';
import 'package:counter_pro/features/logger/domain/repositories/log_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:counter_pro/features/logger/logger.dart';

part 'logger_state.dart';

class LoggerCubit extends Cubit<LoggerState> {
  final LogRepo _logRepo;
  LoggerCubit(this._logRepo) : super(LoggerInitial());

  Future<void> loadLogs() async {
    emit(LoggerLoading());
    try {
      final logs = await _logRepo.getLogs();
      if (logs is DataSuccess) {
        emit(LogsLoaded(logs: logs.data!));
      } else if (logs is ErrorOccured) {
        emit(LoggerError(message: logs.message));
      }
    } catch (e) {
      emit(LoggerError(message: e.toString()));
    }
  }

  void createLog(Log log) async {
    try {
      final currentLogs = state.logs;
      emit(LoggerLoading());
      final updatedLogs = [log, ...currentLogs];
      emit(LogCreated(logs: updatedLogs));
      final logs = await _logRepo.createLog(log);
      if (logs is ErrorOccured) {
        emit(LoggerError(logs: currentLogs, message: logs.message));
      }
    } catch (e) {
      emit(LoggerError(message: e.toString()));
    }
  }

  void deleteLog(Log log) async {
    final List<Log> backup = [];
    backup.addAll(state.logs);
    try {
      final List<Log> currentLogs = [];
      currentLogs.addAll(state.logs);
      emit(LoggerLoading());
      currentLogs.removeWhere((element) => element == log);
      emit(LogDeleted(logs: currentLogs));
      final status = await _logRepo.deleteLog(log);
      print('status: $status');
      if (status is ErrorOccured) {
        emit(LoggerError(logs: backup, message: status.message));
      }
    } catch (e) {
      emit(LoggerError(logs: backup, message: e.toString()));
    }
  }

  void clearLogs() {
    emit(LoggerLoading());
    try {
      emit(const LoggerCleared());
    } catch (e) {
      emit(LoggerError(logs: state.logs, message: e.toString()));
    }
  }
}
