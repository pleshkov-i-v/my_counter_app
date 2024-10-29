import 'package:domain/domain.dart';
import 'package:domain/src/counter/exceptions/counter_negative_value_exception.dart';

abstract interface class ICounterOperationService {
  int perpormOperation({
    required int currentValue,
    required CounterOperationType operationType,
  });
}

class CounterOperationService implements ICounterOperationService {
  @override
  int perpormOperation({
    required int currentValue,
    required CounterOperationType operationType,
  }) {
    // input value must be positive or zero
    if (currentValue < 0) {
      throw CounterNegativeValueException(
        wrongValue: currentValue,
      );
    }

    // new value can be only positive
    switch (operationType) {
      case CounterOperationType.increment:
        return currentValue + 1;
      case CounterOperationType.decrement:
        return currentValue == 0 ? 0 : currentValue - 1;
    }
  }
}
