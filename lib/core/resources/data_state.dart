abstract class DataState<T> {
  final T? data;
  final String? message;
  const DataState({this.data, this.message});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class ErrorOccured<T> extends DataState<T> {
  const ErrorOccured(String message) : super(message: message);
}
