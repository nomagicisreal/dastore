///
///
/// this file contains:
/// [DurationFR], [KDuration]
///
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
/// [VStream]
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

///
///
///
/// [DurationFR], [KDuration]
///
///
///
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

  ///
  /// constants
  ///

  static const milli100 = DurationFR.constant(KDuration.milli100);
  static const milli300 = DurationFR.constant(KDuration.milli300);
  static const milli500 = DurationFR.constant(KDuration.milli500);
  static const milli800 = DurationFR.constant(KDuration.milli800);
  static const milli1500 = DurationFR.constant(KDuration.milli1500);
  static const milli2500 = DurationFR.constant(KDuration.milli2500);
  static const second1 = DurationFR.constant(KDuration.second1);
  static const second2 = DurationFR.constant(KDuration.second2);
  static const second3 = DurationFR.constant(KDuration.second3);
  static const second4 = DurationFR.constant(KDuration.second4);
  static const second5 = DurationFR.constant(KDuration.second5);
  static const second6 = DurationFR.constant(KDuration.second6);
  static const second7 = DurationFR.constant(KDuration.second7);
  static const second8 = DurationFR.constant(KDuration.second8);
  static const second9 = DurationFR.constant(KDuration.second9);
  static const second10 = DurationFR.constant(KDuration.second10);
  static const second20 = DurationFR.constant(KDuration.second20);
  static const second30 = DurationFR.constant(KDuration.second30);
  static const min1 = DurationFR.constant(KDuration.min1);
}

extension KDuration on Duration {
  DurationFR get toDurationFR => DurationFR.constant(this);

  String toStringDayMinuteSecond({String splitter = ':'}) {
    final dayMinuteSecond = toString().substring(0, 7);
    return splitter == ":"
        ? dayMinuteSecond
        : dayMinuteSecond.splitMapJoin(RegExp(':'), onMatch: (_) => splitter);
  }

  static const milli5 = Duration(milliseconds: 5);
  static const milli10 = Duration(milliseconds: 10);
  static const milli20 = Duration(milliseconds: 20);
  static const milli30 = Duration(milliseconds: 30);
  static const milli40 = Duration(milliseconds: 40);
  static const milli50 = Duration(milliseconds: 50);
  static const milli60 = Duration(milliseconds: 60);
  static const milli70 = Duration(milliseconds: 70);
  static const milli80 = Duration(milliseconds: 80);
  static const milli90 = Duration(milliseconds: 90);
  static const milli100 = Duration(milliseconds: 100);
  static const milli110 = Duration(milliseconds: 110);
  static const milli120 = Duration(milliseconds: 120);
  static const milli130 = Duration(milliseconds: 130);
  static const milli140 = Duration(milliseconds: 140);
  static const milli150 = Duration(milliseconds: 150);
  static const milli160 = Duration(milliseconds: 160);
  static const milli170 = Duration(milliseconds: 170);
  static const milli180 = Duration(milliseconds: 180);
  static const milli190 = Duration(milliseconds: 190);
  static const milli200 = Duration(milliseconds: 200);
  static const milli210 = Duration(milliseconds: 210);
  static const milli220 = Duration(milliseconds: 220);
  static const milli230 = Duration(milliseconds: 230);
  static const milli240 = Duration(milliseconds: 240);
  static const milli250 = Duration(milliseconds: 250);
  static const milli260 = Duration(milliseconds: 260);
  static const milli270 = Duration(milliseconds: 270);
  static const milli280 = Duration(milliseconds: 280);
  static const milli290 = Duration(milliseconds: 290);
  static const milli295 = Duration(milliseconds: 295);
  static const milli300 = Duration(milliseconds: 300);
  static const milli306 = Duration(milliseconds: 306);
  static const milli307 = Duration(milliseconds: 307);
  static const milli308 = Duration(milliseconds: 308);
  static const milli310 = Duration(milliseconds: 310);
  static const milli320 = Duration(milliseconds: 320);
  static const milli330 = Duration(milliseconds: 330);
  static const milli335 = Duration(milliseconds: 335);
  static const milli340 = Duration(milliseconds: 340);
  static const milli350 = Duration(milliseconds: 350);
  static const milli360 = Duration(milliseconds: 360);
  static const milli370 = Duration(milliseconds: 370);
  static const milli380 = Duration(milliseconds: 380);
  static const milli390 = Duration(milliseconds: 390);
  static const milli400 = Duration(milliseconds: 400);
  static const milli410 = Duration(milliseconds: 410);
  static const milli420 = Duration(milliseconds: 420);
  static const milli430 = Duration(milliseconds: 430);
  static const milli440 = Duration(milliseconds: 440);
  static const milli450 = Duration(milliseconds: 450);
  static const milli460 = Duration(milliseconds: 460);
  static const milli466 = Duration(milliseconds: 466);
  static const milli467 = Duration(milliseconds: 467);
  static const milli468 = Duration(milliseconds: 468);
  static const milli470 = Duration(milliseconds: 470);
  static const milli480 = Duration(milliseconds: 480);
  static const milli490 = Duration(milliseconds: 490);
  static const milli500 = Duration(milliseconds: 500);
  static const milli600 = Duration(milliseconds: 600);
  static const milli700 = Duration(milliseconds: 700);
  static const milli800 = Duration(milliseconds: 800);
  static const milli810 = Duration(milliseconds: 810);
  static const milli820 = Duration(milliseconds: 820);
  static const milli830 = Duration(milliseconds: 830);
  static const milli840 = Duration(milliseconds: 840);
  static const milli850 = Duration(milliseconds: 850);
  static const milli860 = Duration(milliseconds: 860);
  static const milli870 = Duration(milliseconds: 870);
  static const milli880 = Duration(milliseconds: 880);
  static const milli890 = Duration(milliseconds: 890);
  static const milli900 = Duration(milliseconds: 900);
  static const milli910 = Duration(milliseconds: 910);
  static const milli920 = Duration(milliseconds: 920);
  static const milli930 = Duration(milliseconds: 930);
  static const milli940 = Duration(milliseconds: 940);
  static const milli950 = Duration(milliseconds: 950);
  static const milli960 = Duration(milliseconds: 960);
  static const milli970 = Duration(milliseconds: 970);
  static const milli980 = Duration(milliseconds: 980);
  static const milli990 = Duration(milliseconds: 990);
  static const milli1100 = Duration(milliseconds: 1100);
  static const milli1200 = Duration(milliseconds: 1200);
  static const milli1300 = Duration(milliseconds: 1300);
  static const milli1400 = Duration(milliseconds: 1400);
  static const milli1500 = Duration(milliseconds: 1500);
  static const milli1600 = Duration(milliseconds: 1600);
  static const milli1700 = Duration(milliseconds: 1700);
  static const milli1800 = Duration(milliseconds: 1800);
  static const milli1900 = Duration(milliseconds: 1900);
  static const milli1933 = Duration(milliseconds: 1933);
  static const milli1934 = Duration(milliseconds: 1934);
  static const milli1936 = Duration(milliseconds: 1936);
  static const milli1940 = Duration(milliseconds: 1940);
  static const milli1950 = Duration(milliseconds: 1950);
  static const milli2100 = Duration(milliseconds: 2100);
  static const milli2200 = Duration(milliseconds: 2200);
  static const milli2300 = Duration(milliseconds: 2300);
  static const milli2400 = Duration(milliseconds: 2400);
  static const milli2500 = Duration(milliseconds: 2500);
  static const milli2600 = Duration(milliseconds: 2600);
  static const milli2700 = Duration(milliseconds: 2700);
  static const milli2800 = Duration(milliseconds: 2800);
  static const milli2900 = Duration(milliseconds: 2900);
  static const milli3800 = Duration(milliseconds: 3800);
  static const milli3822 = Duration(milliseconds: 3822);
  static const milli3833 = Duration(milliseconds: 3833);
  static const milli3866 = Duration(milliseconds: 3866);
  static const milli4500 = Duration(milliseconds: 4500);
  static const second1 = Duration(seconds: 1);
  static const second2 = Duration(seconds: 2);
  static const second3 = Duration(seconds: 3);
  static const second4 = Duration(seconds: 4);
  static const second5 = Duration(seconds: 5);
  static const second6 = Duration(seconds: 6);
  static const second7 = Duration(seconds: 7);
  static const second8 = Duration(seconds: 8);
  static const second9 = Duration(seconds: 9);
  static const second10 = Duration(seconds: 10);
  static const second14 = Duration(seconds: 14);
  static const second15 = Duration(seconds: 15);
  static const second20 = Duration(seconds: 20);
  static const second30 = Duration(seconds: 30);
  static const second40 = Duration(seconds: 40);
  static const second50 = Duration(seconds: 50);
  static const second58 = Duration(seconds: 58);
  static const min1 = Duration(minutes: 1);
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
    required Listener onCancel,
  }) {
    final Consumer<Timer> canceler = onCancel == FListener.none
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
    Listener onCancel = FListener.none,
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
    Listener onCancel = FListener.none,
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
    Listener onCancel = FListener.none,
    required Consumer<Timer> listener,
    required int maxSection,
  }) =>
      timerUntilMaxTick(
        frequency: frequency,
        listener: listener,
        maxTick: interval * maxSection,
      );
}

///
///
///
/// timer
///
///
///
extension FTimer on Timer {
  static final Timer zero = Timer(Duration.zero, FListener.none);

  static Timer _nest(
    Duration duration,
    Listener listener,
    Iterable<MapEntry<Duration, Listener>> children,
  ) =>
      Timer(duration, () {
        if (children.isNotEmpty) _sequence(children);
        listener();
      });

  static Timer _sequence(Iterable<MapEntry<Duration, Listener>> elements) {
    final first = elements.first;
    return _nest(first.key, first.value, elements.skip(1));
  }

  static Timer sequencing(List<Duration> steps, List<Listener> listeners) =>
      _sequence(steps.combine(listeners));
}

extension FTimerConsumer on Consumer<Timer> {
  static Consumer<Timer> periodicProcessUntil(int n, Listener listener) {
    int count = 0;
    return (timer) {
      listener();
      if (++count == n) {
        timer.cancel();
      }
    };
  }

  static Consumer<Timer> periodicProcessAfter(int n, Listener listener) {
    int count = 0;
    return (timer) => count < n ? count++ : listener();
  }

  static Consumer<Timer> periodicProcessPeriod(
    int period,
    Listener listener,
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

///
///
/// stream
///
///
extension VStream<T> on Stream<T> {
  static Stream<int> ofInts({
    int start = 0,
    int end = 10,
    Duration delay = KDuration.second1,
  }) async* {
    assert(end >= start);
    for (var i = start; i <= end; i++) {
      yield i;
      await Future.delayed(delay);
    }
  }
}
