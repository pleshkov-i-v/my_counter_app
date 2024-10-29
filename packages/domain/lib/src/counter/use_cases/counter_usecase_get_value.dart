import 'package:domain/domain.dart';
import 'package:domain/src/utils/i_datetime_provider.dart';

class CounterUseCaseGetValue implements ICounterUseCaseGetValue {
  final ICounterRepository _counterRepository;
  final IDateTimeProvider _dateTimeProvider;
  CounterUseCaseGetValue({
    required ICounterRepository counterRepository,
    required IDateTimeProvider dateTimeProvider,
  })  : _counterRepository = counterRepository,
        _dateTimeProvider = dateTimeProvider;

  @override
  Future<int> getCounterValue() async {
    try {
      CounterValueLogEntry? result = await _counterRepository.getCounterValue();
      if (result == null) {
        result = CounterValueLogEntry(
          value: 0,
          date: _dateTimeProvider.now(),
        );
        await _counterRepository.saveCounterValue(value: result);
      }
      return result.value;
    } on DomainException {
      rethrow;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        CounterUnknownException(error: e),
        stackTrace,
      );
    }
  }
}
