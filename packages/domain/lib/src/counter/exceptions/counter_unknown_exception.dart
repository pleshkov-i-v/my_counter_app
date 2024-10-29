import 'package:domain/domain.dart';

class CounterUnknownException extends DomainException {
  final Object error;
  CounterUnknownException({
    required this.error,
  });
}
