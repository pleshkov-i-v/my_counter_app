import 'package:domain/domain.dart';

class CounterNegativeValueException extends DomainException {
  final int wrongValue;
  CounterNegativeValueException({
    required this.wrongValue,
  });
}
