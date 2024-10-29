import 'package:domain/domain.dart';

class CounterRepositoryException extends DomainException {
  final String message;
  CounterRepositoryException({
    required this.message,
  });
}
