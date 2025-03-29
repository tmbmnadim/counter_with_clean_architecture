import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'logger_state.dart';

class LoggerCubit extends Cubit<LoggerState> {
  LoggerCubit() : super(LoggerInitial());
}
