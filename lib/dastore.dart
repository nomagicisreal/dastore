library dastore;

import 'dart:async';
import 'dart:math' as math;

part 'extension/collection.dart';
part 'extension/concurrent.dart';
part 'extension/others.dart';
part 'extension/function.dart';

///
///
/// some static methods implementation should be directly used in production mode,
/// instead of invoking these extension by passing arguments into function
///
///
/// [Supplier]
/// [Consumer]
/// [Mapper]
/// [Reducer]
/// [Companion]
/// [Translator]
/// [Combiner]
/// [Mixer]
/// [Supporter]
/// [Fusionor]
/// [Decider]
/// [Sequencer]
///
/// [Predicator], [PredicatorTernary]
/// [Generator], [Generator2D]
///
///
///

typedef Listener = void Function();
typedef Supplier<T> = T Function();
typedef Consumer<T> = void Function(T value);
typedef Absorber<A, B> = void Function(A a, B b);
typedef Mapper<T> = T Function(T value);
typedef Reducer<T> = T Function(T v1, T v2);
typedef Companion<T, S> = T Function(T origin, S another);
typedef Translator<T, S> = S Function(T value);
typedef Combiner<T, S> = S Function(T v1, T v2);
typedef Mixer<P, Q, S> = S Function(P p, Q q);
typedef Fusionor<O, P, Q, S> = S Function(O o, P p, Q q);
typedef Supporter<T> = T Function(Supplier<int> indexing);
typedef Decider<T, S> = Consumer<T> Function(S toggle);
typedef Sequencer<R, S, I> = Translator<int, R> Function(
    S previous,
    S next,
    I interval,
    );
// typedef Conductor<T> = void Function(T a, T b);

typedef Predicator<T> = bool Function(T a);
typedef PredicateCombiner<T> = bool Function(T v1, T v2);
typedef Checker<T> = bool Function(int index, T value);
typedef Generator<T> = T Function(int index);
typedef GeneratorTranslator<T, S> = S Function(int index, T value);
typedef GeneratorFolder<P, Q, S> = S Function(int index, P p, Q q);
typedef GeneratorReducer<T> = T Function(int index, T v1, T v2);
typedef Generator2D<T> = T Function(int i, int j);
typedef Differentiator<P, Q> = int Function(P p, Q q);
