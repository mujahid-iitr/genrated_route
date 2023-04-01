part of 'counter_cubit.dart';

class CounterState {
  int counterValue;
  bool wasIncremented;

  CounterState({
    @required this.counterValue,
    this.wasIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'counterValue': this.counterValue,
      'wasIncremented': this.wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncremented: map['wasIncremented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));
}
