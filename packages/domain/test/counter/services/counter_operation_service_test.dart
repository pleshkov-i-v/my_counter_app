import 'package:domain/domain.dart';
import 'package:domain/src/counter/exceptions/counter_negative_value_exception.dart';
import 'package:domain/src/counter/services/counter_operation_service.dart';
import 'package:test/test.dart';

void main() {
  group('CounterOperationService', () {
    test(
      'positive value, increment - successful, incremented value',
      () {
        final service = CounterOperationService();

        final result = service.perpormOperation(
          currentValue: 1,
          operationType: CounterOperationType.increment,
        );
        expect(result, 2);
      },
    );

    test(
      'zero value, increment - successful, incremented value',
      () {
        final service = CounterOperationService();

        final result = service.perpormOperation(
          currentValue: 0,
          operationType: CounterOperationType.increment,
        );
        expect(result, 1);
      },
    );

    test(
      'positive value, decrement - successful, decremented value',
      () {
        final service = CounterOperationService();

        final result = service.perpormOperation(
          currentValue: 1,
          operationType: CounterOperationType.decrement,
        );
        expect(result, 0);
      },
    );

    test(
      'zero value, decrement - successful, same value',
      () {
        final service = CounterOperationService();

        final result = service.perpormOperation(
          currentValue: 0,
          operationType: CounterOperationType.decrement,
        );
        expect(result, 0);
      },
    );

    test(
      'negative value, increment - throws',
      () {
        final service = CounterOperationService();

        expect(
          () => service.perpormOperation(
            currentValue: -1,
            operationType: CounterOperationType.increment,
          ),
          throwsA(
            isA<CounterNegativeValueException>().having(
              (exeption) => exeption.wrongValue,
              'wrongValue',
              -1,
            ),
          ),
        );
        // check the value is not hardcoded
        expect(
          () => service.perpormOperation(
            currentValue: -5,
            operationType: CounterOperationType.increment,
          ),
          throwsA(
            isA<CounterNegativeValueException>().having(
              (exeption) => exeption.wrongValue,
              'wrongValue',
              -5,
            ),
          ),
        );
      },
    );
  });
}
