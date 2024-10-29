import 'package:domain/domain.dart';

abstract interface class ICounterRepository {
  /// Returns the latest value of the counter
  Future<CounterValueLogEntry?> getCounterValue();
  Future<void> saveCounterValue({
    required CounterValueLogEntry value,
  });
}
