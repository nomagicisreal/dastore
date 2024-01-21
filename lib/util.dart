///
///
/// this file contains:
/// [kVoidCallback], [clampDoublePositive]
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
/// [Extruding]
/// [TextFormFieldValidator]
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

const VoidCallback kVoidCallback = _voidCallback;

void _voidCallback() {}

double clampDoublePositive(double value) => clampDouble(
      value,
      0.0,
      double.infinity,
    );

typedef Supplier<T> = T Function();
typedef Consumer<T> = void Function(T value);
typedef Absorber<A, B> = void Function(A a, B b);
typedef Mapper<T> = T Function(T value);
typedef Reducer<T> = T Function(T v1, T v2);
typedef Companion<T, S> = T Function(T host, S value);
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
typedef PredicatorTernary<T> = bool? Function(T value);
typedef Checker<T> = bool Function(T value, int index);
typedef Generator<T> = T Function(int index);
typedef GeneratorFolder<P, Q, S> = S Function(int index, P p, Q q);
typedef GeneratorReducer<T> = T Function(int index, T v1, T v2);
typedef Generator2D<T> = T Function(int i, int j);
typedef Differentiator<P, Q> = int Function(P p, Q q);
typedef Extruding = Rect Function(double width, double height);

typedef WidgetChildrenBuilder = Widget Function(
  BuildContext context,
  List<Widget> children,
);
typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);

