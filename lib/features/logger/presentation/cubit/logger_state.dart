part of 'logger_cubit.dart';

abstract class LoggerState extends Equatable {
  const LoggerState();

  @override
  List<Object> get props => [];
}

class LoggerInitial extends LoggerState {}
