///
///
/// this file contains:
/// [kVoidCallback], [clampDoublePositive]
///
/// [Predicator], [PredicatorTernary]
///
/// [Supplier]         (return value without argument)
/// [Consumer]         (return void, with 1 argument)
/// [Decider]          (return [Consumer], with 1 argument)
/// [Mapper]           (return value that has the same type with argument)
/// [Generator]        (return value from index)
/// [Supporter]        (return value from index [Supplier])
/// [Translator]       (return valur from argument in different type)
/// [Sequencer]        (return [Translator]<[int], [R]> that comes from "previous", "next", "interval" for list generation)
/// [Companion]        (return value that has the same type with first argument with a companion argument)
/// ?? [Conductor]                   (with 2 argument, return void)
/// ?? [Reducer]                     (return value that comes from two argument with same type)
///
/// [TextFormFieldValidator]
///
/// [DirectionExtruding]
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

typedef Predicator<T> = bool Function(T a);
typedef PredicatorTernary<T> = bool? Function(T value);

// generics
typedef Supplier<T> = T Function();
typedef Consumer<T> = void Function(T value);
typedef Combiner<T, S> = S Function(T v1, T v2);
typedef Decider<T, S> = Consumer<T> Function(S toggle);
typedef Mapper<T> = T Function(T value);
typedef Generator<T> = T Function(int index);
typedef Supporter<T> = T Function(Supplier<int> indexing);
typedef Translator<T, S> = S Function(T value);
typedef Sequencer<R, S, I> = Translator<int, R> Function(
  S previous,
  S next,
  I interval,
);
typedef Companion<T, S> = T Function(T host, S value);
// typedef Conductor<T> = void Function(T a, T b);
// typedef Reducer<T> = T Function(T v1, T v2);

typedef Generator2D<T> = T Function(int i, int j);


typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);

typedef DirectionExtruding = Rect Function(double width, double height);
