import 'models/counter_value_dto.dart';

abstract interface class ICounterStorage {
  Future<CounterValueDto> getCounterValue();
  Future<void> saveCounterValue(CounterValueDto value);
}
