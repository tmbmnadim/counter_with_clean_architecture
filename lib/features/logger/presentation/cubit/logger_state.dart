part of 'logger_cubit.dart';

abstract class LoggerState extends Equatable {
  final List<Log> logs;
  final String? message;
  const LoggerState({
    this.logs = const [],
    this.message,
  });

  @override
  List<Object> get props => [];
}

class LoggerInitial extends LoggerState {}

class LoggerLoading extends LoggerState {}

class LogsLoaded extends LoggerState {
  const LogsLoaded({required super.logs});

  @override
  List<Object> get props => [logs];
}

class LogCreated extends LoggerState {
  const LogCreated({super.logs});

  @override
  List<Object> get props => [logs];
}

class LogDeleted extends LoggerState {
  const LogDeleted({super.logs});

  @override
  List<Object> get props => [logs];
}

class LoggerCleared extends LoggerState {
  const LoggerCleared();

  @override
  List<Object> get props => [logs];
}

class LoggerError extends LoggerState {
  const LoggerError({super.logs, required super.message});

  @override
  List<Object> get props => [message ?? ''];
}
