import 'package:domain/domain.dart';

class CounterRepositoryInMemoryImplementation implements ICounterRepository {
  final List<CounterValueLogEntry> _values = [];

  @override
  Future<CounterValueLogEntry?> getCounterValue() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _values.lastOrNull;
  }

  @override
  Future<void> saveCounterValue({required CounterValueLogEntry value}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _values.add(value);
  }
}
