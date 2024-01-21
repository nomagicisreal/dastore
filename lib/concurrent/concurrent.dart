///
///
/// this file contains:
/// [DurationFR], [CurveFR]
///
/// [DurationExtension], [CurveExtension]
///
/// [DateTimeExtension]
///
/// [StreamExtension]
/// [StreamIterableExtension]
/// [IterableStreamSubscriptionsExtension]
///
///
/// [Beats]
/// [BeatsOfInstrument]
///
/// [FTimer]
/// [FTimerConsumer]
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
part of dastore;

class DurationFR {
  final Duration forward;
  final Duration reverse;

  const DurationFR(this.forward, this.reverse);

  const DurationFR.constant(Duration duration)
      : forward = duration,
        reverse = duration;

  static const DurationFR zero = DurationFR.constant(Duration.zero);

  DurationFR operator ~/(int value) =>
      DurationFR(forward ~/ value, reverse ~/ value);

  DurationFR operator +(Duration value) =>
      DurationFR(forward + value, reverse + value);

  DurationFR operator -(Duration value) =>
      DurationFR(forward - value, reverse - value);

  @override
  int get hashCode => Object.hash(forward, reverse);

  @override
  bool operator ==(covariant DurationFR other) => hashCode == other.hashCode;

  @override
  String toString() => 'DurationFR(forward: $forward, reverse:$reverse)';
}

class CurveFR {
  final Curve forward;
  final Curve reverse;

  const CurveFR(this.forward, this.reverse);

  const CurveFR.symmetry(Curve curve)
      : forward = curve,
        reverse = curve;

  CurveFR.intervalFlip(CurveFR curve, double begin, double end)
      : forward = Interval(begin, end, curve: curve.forward),
        reverse = Interval(begin, end, curve: curve.reverse);

  CurveFR interval(double begin, double end) => CurveFR(
        Interval(begin, end, curve: forward),
        Interval(begin, end, curve: reverse),
      );

  CurveFR get flipped => CurveFR(reverse, forward);
}

extension DurationExtension on Duration {
  DurationFR get toDurationFR => DurationFR.constant(this);
  String toStringDayMinuteSecond({String splitter = ':'}) {
    final dayMinuteSecond = toString().substring(0, 7);
    return splitter == ":"
        ? dayMinuteSecond
        : dayMinuteSecond.splitMapJoin(RegExp(':'), onMatch: (_) => splitter);
  }
}

extension CurveExtension on Curve {
  CurveFR get toCurveFR => CurveFR(this, this);
}

extension DateTimeExtension on DateTime {
  static bool isSameDay(DateTime? a, DateTime? b) => a == null || b == null
      ? false
      : a.year == b.year && a.month == b.month && a.day == b.day;

  String get date => toString().split(' ').first; // $y-$m-$d

  String get time => toString().split(' ').last; // $h:$min:$sec.$ms$us

  int get monthDays => switch (month) {
        1 => 31,
        2 => year % 4 == 0
            ? year % 100 == 0
                ? year % 400 == 0
                    ? 29
                    : 28
                : 29
            : 28,
        3 => 31,
        4 => 30,
        5 => 31,
        6 => 30,
        7 => 31,
        8 => 31,
        9 => 30,
        10 => 31,
        11 => 30,
        12 => 31,
        _ => throw UnimplementedError(),
      };

  static String parseTimestampOf(String string) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(string)).toIso8601String();
}

///
///
///
///
/// stream
///
///
///
///

extension StreamExtension<M> on Stream<M> {
  static Stream<T> generateFromIterable<T>(
      int count, {
        Generator<T>? generator,
      }) =>
      Stream.fromIterable(Iterable.generate(count, generator));

  static Stream<int> intOf({
    int start = 1,
    int end = 10,
    Duration interval = KDuration.second1,
    bool startWithDelay = true,
  }) async* {
    Future<int> yielding(int value) async =>
        Future.delayed(interval).then((_) => value);

    Future<void> delay() async =>
        startWithDelay ? Future.delayed(interval) : null;

    if (end >= start) {
      await delay();
      for (var value = start; value <= end; value++) {
        yield await yielding(value);
      }
    } else {
      await delay();
      for (var value = start; value >= end; value--) {
        yield await yielding(value);
      }
    }
  }

  Stream<M> get whereDiff {
    M? previousValue;
    return where((event) {
      if (previousValue == event) {
        return false;
      } else {
        previousValue = event;
        return true;
      }
    });
  }
}

extension StreamIterableExtension<T, I extends Iterable<T>> on Stream<I> {
  Stream<int> get mapLength => map((items) => items.length);

  Stream<Iterable<T>> mapWhere(bool Function(T item) checker) =>
      map((Iterable<T> items) => items.where(checker));
}

extension IterableStreamSubscriptionsExtension on Iterable<StreamSubscription> {
  void pauseAll() => fold<void>(null, (_, stream) => stream.pause());

  void resumeAll() => fold<void>(null, (_, stream) => stream.resume());

  void cancelAll() => fold<void>(null, (_, stream) => stream.cancel());
}

///
///
///
///
///
/// audio
///
///
///
///
///

class Beats {
  final Duration segment;

  const Beats(this.segment);

  static Consumer<Timer> _limitedListener({
    required Consumer<Timer> listener,
    required int maxTick,
    required VoidCallback onCancel,
  }) {
    final Consumer<Timer> canceler = onCancel == kVoidCallback
        ? (timer) => timer.cancel()
        : (timer) {
            onCancel();
            timer.cancel();
          };
    return (timer) => timer.tick > maxTick ? canceler(timer) : listener(timer);
  }

  static Consumer<Timer> _checkIfListenOnSequences({
    required Iterable<int> sequences,
    required int totalInterval,
    required Consumer<Timer> listener,
  }) =>
      sequences.length == totalInterval
          ? listener
          : (timer) {
              try {
                // the last sequences in beats is 0
                if (sequences.contains(timer.tick % totalInterval)) {
                  listener(timer);
                }
              } finally {}
            };

  ///
  /// duration -> listener -> duration -> listener ...
  ///

  Timer timerOf({
    Consumer<Timer>? listener,
    VoidCallback onCancel = kVoidCallback,
    required BeatsStyle style,
  }) =>
      Timer.periodic(
        segment ~/ style.interval,
        _limitedListener(
          listener: _checkIfListenOnSequences(
            sequences: style.sequences,
            totalInterval: style.modulus,
            listener: listener ?? (timer) {},
          ),
          maxTick: style.maxTick,
          onCancel: onCancel,
        ),
      );
}

class BeatsStyle {
  final int interval;
  final int frequency;
  final int maxTick;
  final Iterable<int> sequences;

  int get modulus => interval * frequency;

  const BeatsStyle({
    this.frequency = 1, // tick on every segment
    required this.interval,
    required this.maxTick,
    required this.sequences,
  });

  const BeatsStyle.of8({
    this.frequency = 1,
    this.sequences = sequence1To8,
    required this.maxTick,
  }) : interval = 8;

  const BeatsStyle.of16({
    this.frequency = 1,
    this.sequences = sequence1To16,
    required this.maxTick,
  }) : interval = 16;

  static const List<int> sequence1 = [1];
  static const List<int> sequence1To8 = [1, 2, 3, 4, 5, 6, 7, 8];
  static const List<int> sequence1To16 = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16
  ];
}

class BeatsOfInstrument extends Beats {
  final int interval;
  final Iterable<int> sequences;

  const BeatsOfInstrument(
    super.segment, {
    required this.interval,
    required this.sequences,
  });

  Timer timerUntilMaxTick({
    int frequency = 1,
    VoidCallback onCancel = kVoidCallback,
    required Consumer<Timer> listener,
    required int maxTick,
  }) =>
      timerOf(
        listener: listener,
        style: BeatsStyle(
          interval: interval,
          frequency: frequency,
          maxTick: maxTick,
          sequences: sequences,
        ),
        onCancel: onCancel,
      );

  Timer timerUntilMaxSection({
    int frequency = 1,
    VoidCallback onCancel = kVoidCallback,
    required Consumer<Timer> listener,
    required int maxSection,
  }) =>
      timerUntilMaxTick(
        frequency: frequency,
        listener: listener,
        maxTick: interval * maxSection,
      );
}

extension FTimer on Timer {
  static Timer _nest(
    Duration duration,
    VoidCallback listener,
    Iterable<MapEntry<Duration, VoidCallback>> children,
  ) =>
      Timer(duration, () {
        children.isNotEmpty ? _sequence(children) : null;
        listener();
      });

  static Timer _sequence(Iterable<MapEntry<Duration, VoidCallback>> elements) {
    final first = elements.first;
    return _nest(first.key, first.value, elements.skip(1));
  }

  static Timer sequencing(List<Duration> steps, List<VoidCallback> listeners) =>
      _sequence(steps.combine(listeners));
}

extension FTimerConsumer on Consumer<Timer> {
  static Consumer<Timer> periodicProcessUntil(int n, VoidCallback listener) {
    int count = 0;
    return (timer) {
      listener();
      if (++count == n) {
        timer.cancel();
      }
    };
  }

  static Consumer<Timer> periodicProcessAfter(int n, VoidCallback listener) {
    int count = 0;
    return (timer) => count < n ? count++ : listener();
  }

  static Consumer<Timer> periodicProcessPeriod(
    int period,
    VoidCallback listener,
  ) {
    int count = 0;
    void listenIf(bool value) => value ? listener() : null;
    bool shouldListen() => count % period == 0;

    return (timer) {
      listenIf(shouldListen());
      count++;
    };
  }
}

