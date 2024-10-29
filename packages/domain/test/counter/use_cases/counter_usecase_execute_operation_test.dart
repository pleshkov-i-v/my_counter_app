import 'package:domain/src/counter/services/counter_operation_service.dart';
import 'package:domain/src/counter/use_cases/counter_usecase_execute_operation.dart';
import 'package:domain/src/utils/i_datetime_provider.dart';
import 'package:test/test.dart';
import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/fake_counter_value.dart';
import '../mocks/mock_counter_operation_service.dart';
import '../mocks/mock_counter_repository.dart';
import '../mocks/mock_datetime_provider.dart';

// 1. repository returns value, it goes to operation service, result is saved
// 2. repository returns no value, default value is 0, it goes to operation service, result is saved
// 3. repository throws on get - exception is rethrown
// 4. operation service throws - exception is rethrown - can be omitted
// 5. repository throws on save - exception is rethrown

void main() {
  final previousValueDate = DateTime(2024, 10, 30, 15, 10, 32);
  const previousValue = 5;
  const resultValue = 42;
  const defaultValue = 0;
  final nowDateTime = DateTime(2024, 10, 30, 15, 11, 48);

  setUpAll(() {
    registerFallbackValue(FakeCounterValue());
    registerFallbackValue(CounterOperationType.increment);
  });
  group('CounterUseCaseExecuteOperation', () {
    test('last value exists, operation performed, result saved - success',
        () async {
      ICounterRepository repository = MockCounterRepository();
      IDateTimeProvider dateTimeProvider = MockDateTimeProvider();
      ICounterOperationService counterOperationService =
          MockCounterOperationService();
      CounterUseCaseExecuteOperation useCase = CounterUseCaseExecuteOperation(
        counterRepository: repository,
        dateTimeProvider: dateTimeProvider,
        counterOperationService: counterOperationService,
      );

      when(
        () => repository.getCounterValue(),
      ).thenAnswer(
        (_) async => CounterValueLogEntry(
          value: previousValue,
          date: previousValueDate,
        ),
      );
      when(
        () => repository.saveCounterValue(value: any(named: 'value')),
      ).thenAnswer(
        (_) async => Future<void>.value(),
      );
      when(
        () => dateTimeProvider.now(),
      ).thenAnswer(
        (_) => nowDateTime,
      );
      when(
        () => counterOperationService.perpormOperation(
          currentValue: any(named: 'currentValue'),
          operationType: any(named: 'operationType'),
        ),
      ).thenAnswer(
        (_) => resultValue,
      );

      await useCase.executeOperation(
        operationType: CounterOperationType.increment,
      );
      verify(() => repository.getCounterValue()).called(1);
      verify(
        () => counterOperationService.perpormOperation(
          currentValue: any(
            named: 'currentValue',
            that: isA<int>().having((p0) => p0, 'currentValue', previousValue),
          ),
          operationType: any(
            named: 'operationType',
          ),
        ),
      ).called(1);
      verify(
        () => repository.saveCounterValue(
          value: any(
            named: 'value',
            that: isA<CounterValueLogEntry>()
                .having((p0) => p0.value, 'value', resultValue)
                .having((p0) => p0.date, 'date', nowDateTime),
          ),
        ),
      ).called(1);
    });

    test('there is no last value, operation performed, result saved - success',
        () async {
      ICounterRepository repository = MockCounterRepository();
      IDateTimeProvider dateTimeProvider = MockDateTimeProvider();
      ICounterOperationService counterOperationService =
          MockCounterOperationService();
      CounterUseCaseExecuteOperation useCase = CounterUseCaseExecuteOperation(
        counterRepository: repository,
        dateTimeProvider: dateTimeProvider,
        counterOperationService: counterOperationService,
      );

      when(
        () => repository.getCounterValue(),
      ).thenAnswer(
        (_) async => null,
      );
      when(
        () => repository.saveCounterValue(value: any(named: 'value')),
      ).thenAnswer(
        (_) async => Future<void>.value(),
      );
      when(
        () => dateTimeProvider.now(),
      ).thenAnswer(
        (_) => nowDateTime,
      );
      when(
        () => counterOperationService.perpormOperation(
          currentValue: any(named: 'currentValue'),
          operationType: any(named: 'operationType'),
        ),
      ).thenAnswer(
        (_) => resultValue,
      );

      await useCase.executeOperation(
        operationType: CounterOperationType.increment,
      );
      verify(() => repository.getCounterValue()).called(1);
      verify(
        () => counterOperationService.perpormOperation(
          currentValue: any(
            named: 'currentValue',
            that: isA<int>().having((p0) => p0, 'currentValue', defaultValue),
          ),
          operationType: any(
            named: 'operationType',
          ),
        ),
      ).called(1);
      verify(
        () => repository.saveCounterValue(
          value: any(
            named: 'value',
            that: isA<CounterValueLogEntry>()
                .having((p0) => p0.value, 'value', resultValue)
                .having((p0) => p0.date, 'date', nowDateTime),
          ),
        ),
      ).called(1);
    });
  });
}
