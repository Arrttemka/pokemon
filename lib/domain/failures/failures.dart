abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);

  factory NetworkFailure.noConnection() =>
      const NetworkFailure('No internet connection. Please connect to the internet and try again.');
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message) : super(message);

  factory UnexpectedFailure.fromException(Exception e) =>
      UnexpectedFailure('An unexpected error occurred: ${e.toString()}');
}