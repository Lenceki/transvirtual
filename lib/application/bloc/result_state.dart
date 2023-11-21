class ResultStateType {}
class ResultLoading extends ResultStateType {}
class ResultInitial extends ResultStateType {}

class ResultError extends ResultStateType {
  late String message;
  ResultError(this.message);
}

class ResultSuccess<T> extends ResultStateType {
  late T data;
  ResultSuccess(this.data);
}
