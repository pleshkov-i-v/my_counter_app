import 'package:domain/domain.dart';
import 'package:domain/src/counter/services/counter_operation_service.dart';
import 'package:domain/src/utils/i_datetime_provider.dart';

class CounterUseCaseExecuteOperation
    implements ICounterUseCaseExecuteOperation {
  final ICounterRepository _counterRepository;
  final IDateTimeProvider _dateTimeProvider;
  final ICounterOperationService _counterOperationService;
  CounterUseCaseExecuteOperation({
    required ICounterRepository counterRepository,
    required IDateTimeProvider dateTimeProvider,
    required ICounterOperationService counterOperationService,
  })  : _counterRepository = counterRepository,
        _dateTimeProvider = dateTimeProvider,
        _counterOperationService = counterOperationService;
  @override
  Future<void> executeOperation({
    required CounterOperationType operationType,
  }) async {
    try {
      final CounterValueLogEntry? currentValueObject =
          await _counterRepository.getCounterValue();
      final currentDate = _dateTimeProvider.now();
      final currentValue = currentValueObject?.value ?? 0;
      final newValue = _counterOperationService.perpormOperation(
        currentValue: currentValue,
        operationType: operationType,
      );
      final result = CounterValueLogEntry(
        value: newValue,
        date: currentDate,
      );
      await _counterRepository.saveCounterValue(value: result);
    } on DomainException {
      rethrow;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CounterUnknownException(error: e),
        stackTrace,
      );
    }
  }
}
