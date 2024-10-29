import 'package:domain/domain.dart';
import 'package:domain/src/counter/services/counter_operation_service.dart';
import 'package:domain/src/counter/use_cases/counter_usecase_execute_operation.dart';
import 'package:domain/src/counter/use_cases/counter_usecase_get_value.dart';
import 'package:domain/src/utils/datetime_provider.dart';

class CounterUseCasesFactory implements ICounterUseCasesFactory {
  CounterUseCasesFactory({required ICounterRepository counterRepository})
      : _counterRepository = counterRepository,
        _counterOperationService = CounterOperationService(),
        _dateTimeProvider = DateTimeProvider();
  final ICounterRepository _counterRepository;
  final DateTimeProvider _dateTimeProvider;
  final CounterOperationService _counterOperationService;
  @override
  ICounterUseCaseExecuteOperation getCounterUseCaseExecuteOperation() =>
      CounterUseCaseExecuteOperation(
        counterRepository: _counterRepository,
        dateTimeProvider: _dateTimeProvider,
        counterOperationService: _counterOperationService,
      );

  @override
  ICounterUseCaseGetValue getCounterUseCaseGetValue() => CounterUseCaseGetValue(
        counterRepository: _counterRepository,
        dateTimeProvider: _dateTimeProvider,
      );
}
