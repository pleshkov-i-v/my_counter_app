import 'package:domain/src/counter/use_cases/counter_usecase_get_value.dart';
import 'package:domain/src/utils/i_datetime_provider.dart';
import 'package:test/test.dart';
import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_counter_repository.dart';
import '../mocks/mock_datetime_provider.dart';

void main() {
  group('CounterUseCaseGetValue', () {
    test('repository has value - returns value', () async {
      ICounterRepository repository = MockCounterRepository();
      IDateTimeProvider dateTimeProvider = MockDateTimeProvider();
      CounterUseCaseGetValue useCase = CounterUseCaseGetValue(
        counterRepository: repository,
        dateTimeProvider: dateTimeProvider,
      );
      final date = DateTime(2024, 10, 30);

      when(
        () => repository.getCounterValue(),
      ).thenAnswer(
        (_) async => CounterValueLogEntry(
          value: 5,
          date: date,
        ),
      );

      final result = await useCase.getCounterValue();
      expect(result, 5);
    });

    test('repository has no value - returns 0', () async {
      ICounterRepository repository = MockCounterRepository();
      IDateTimeProvider dateTimeProvider = MockDateTimeProvider();
      CounterUseCaseGetValue useCase = CounterUseCaseGetValue(
        counterRepository: repository,
        dateTimeProvider: dateTimeProvider,
      );
      when(
        () => repository.getCounterValue(),
      ).thenAnswer(
        (_) async => null,
      );

      final result = await useCase.getCounterValue();
      expect(result, 0);
    });

    test('repository throws an exception - throws CounterRepositoryException',
        () async {
      ICounterRepository repository = MockCounterRepository();
      IDateTimeProvider dateTimeProvider = MockDateTimeProvider();
      CounterUseCaseGetValue useCase = CounterUseCaseGetValue(
        counterRepository: repository,
        dateTimeProvider: dateTimeProvider,
      );
      when(
        () => repository.getCounterValue(),
      ).thenThrow(
        CounterRepositoryException(message: ''),
      );

      final future = useCase.getCounterValue();

      verify(() => repository.getCounterValue()).called(1);
      expectLater(future, throwsA(isA<CounterRepositoryException>()));
    });

    test(
        'repository throws an unexpected exception - throws CounterUnknownException',
        () async {
      ICounterRepository repository = MockCounterRepository();
      IDateTimeProvider dateTimeProvider = MockDateTimeProvider();
      CounterUseCaseGetValue useCase = CounterUseCaseGetValue(
        counterRepository: repository,
        dateTimeProvider: dateTimeProvider,
      );
      when(
        () => repository.getCounterValue(),
      ).thenThrow(
        Exception(),
      );

      final future = useCase.getCounterValue();

      verify(() => repository.getCounterValue()).called(1);
      expectLater(future, throwsA(isA<CounterUnknownException>()));
    });
  });
}
