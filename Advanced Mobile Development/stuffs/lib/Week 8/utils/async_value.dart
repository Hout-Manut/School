enum AsyncValueState { initial, loading, error, success, empty }

class AsyncValue<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;

  bool get isLoading => state == AsyncValueState.loading;
  bool get isError => state == AsyncValueState.error;
  bool get isSuccess => state == AsyncValueState.success;
  bool get isEmpty => state == AsyncValueState.empty;

  AsyncValue._({this.data, this.error, required this.state});

  factory AsyncValue.initial() => AsyncValue._(state: AsyncValueState.initial);
  factory AsyncValue.loading() => AsyncValue._(state: AsyncValueState.loading);

  factory AsyncValue.success(T data) =>
      AsyncValue._(data: data, state: AsyncValueState.success);

  factory AsyncValue.error(Object error) =>
      AsyncValue._(error: error, state: AsyncValueState.error);
  factory AsyncValue.empty(T data) =>
      AsyncValue._(data: data, state: AsyncValueState.empty);
}
