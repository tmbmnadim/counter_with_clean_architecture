import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:counter_pro/features/logger/logger.dart';

part 'logger_state.dart';

class LoggerCubit extends Cubit<LoggerState> {
  LoggerCubit() : super(LoggerInitial());

  void loadLogs() {
    emit(LoggerLoading());
    try {
      emit(LogsLoaded(logs: state.logs));
    } catch (e) {
      emit(LoggerError(message: e.toString()));
    }
  }

  void createLog(Log log) {
    final currentLogs = state.logs;
    emit(LoggerLoading());
    try {
      final updatedLogs = [...currentLogs, log];
      emit(LogCreated(logs: updatedLogs));
    } catch (e) {
      emit(LoggerError(message: e.toString()));
    }
  }

  void deleteLog(int index) {
    final currentLogs = state.logs;
    emit(LoggerLoading());
    try {
      final updatedLogs = [...currentLogs]..removeAt(index);
      emit(LogDeleted(logs: updatedLogs));
    } catch (e) {
      emit(LoggerError(logs: state.logs, message: e.toString()));
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
