class CounterValueLogEntry {
  const CounterValueLogEntry({
    required this.value,
    required this.date,
  });

  final int value;
  final DateTime date;

  @override
  String toString() {
    return 'CounterValueLogEntry{value: $value, date: $date}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CounterValueLogEntry &&
        other.value == value &&
        other.date == date;
  }

  @override
  int get hashCode => value.hashCode ^ date.hashCode;
}
