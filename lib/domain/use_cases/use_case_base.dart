abstract class NormalUseCase<In, Out> {
  Out call(In params);
}

abstract class NoParamsUseCase<Out> {
  Out call();
}

abstract class NormalFutureUseCase<In, Out> {
  Future<Out> call(In params);
}

abstract class FutureNoParamsUseCase<Out> {
  Future<Out> call();
}
