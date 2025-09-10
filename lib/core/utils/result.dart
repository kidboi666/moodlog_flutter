sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;
  const factory Result.failure(Object error) = Failure._;
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Failure<T> extends Result<T> {
  final Object error;

  const Failure._(this.error);

  @override
  String toString() => 'Result<$T>.error($error)';
}
