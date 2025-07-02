abstract class DataState<T> {
  final T? data;
  final ApiError? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ApiError error) : super(error: error);
}

class DataNotSet<T> extends DataState<T> {
  const DataNotSet();
}

class ApiError {
  int code;
  String msg;
  dynamic data;
  ApiError({required this.code, required this.msg, this.data});
}

class ErrorLoadedLocalData extends ApiError {
  ErrorLoadedLocalData() : super(code: 0, msg: "ErrorLoadedLocalData");
}


