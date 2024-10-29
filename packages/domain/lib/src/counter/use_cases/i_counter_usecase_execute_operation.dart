import 'package:domain/domain.dart';

abstract interface class ICounterUseCaseExecuteOperation {
  Future<void> executeOperation({
    required CounterOperationType operationType,
  });
}
