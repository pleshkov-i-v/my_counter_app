import 'package:domain/src/utils/i_datetime_provider.dart';

class DateTimeProvider implements IDateTimeProvider {
  @override
  DateTime now() {
    return DateTime.now();
  }
}
