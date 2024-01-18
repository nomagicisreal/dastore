import 'dart:math' as math;

void main(List<String> arguments) {
  // print('Hello world: ${dastore.calculate()}!');
  // runApp(const MyApp());

  final iterable = [
    [11, 11, 14, 199],
    [24, 222, 242, 2090, 294],
    [333, 38],
  ];

  final iterable2 = [
    [333, 38],
    [24, 222, 242, 2090, 294],
    [11, 11, 14, 199],
  ];
  print(
    iterable.foldWith2D<int, int>(
      iterable2,
      0,
      (value, i1, i2) {
        final v = i1.digitFirst() + i2.digitFirst();
        print('$value, $i1, $i2');
        return value + v;
      },
    ),
  );
}

typedef Absorber<P, Q> = void Function(P p, Q q);
typedef Fusionor<O, P, Q, S> = S Function(O o, P p, Q q);

extension mfiev<I> on Iterable<I> {
  void iteratingWith<S>(Iterable<S> another, Absorber<I, S> absorber) {
    assert(length == another.length, 'length must be equal');
    final iterator = this.iterator;
    final iteratorAnother = another.iterator;
    while (iterator.moveNext() && iteratorAnother.moveNext()) {
      absorber(iterator.current, iteratorAnother.current);
    }
  }
  S foldWith<S, P>(
      Iterable<P> another,
      S initialValue,
      Fusionor<S, I, P, S> fusionor,
      ) {
    var value = initialValue;
    iteratingWith(
      another,
          (e, eAnother) => value = fusionor(value, e, eAnother),
    );
    return value;
  }
}
extension mveivi<I> on Iterable<Iterable<I>> {
  S foldWith2D<S, P>(
      Iterable<Iterable<P>> another,
      S initialValue,
      Fusionor<S, I, P, S> fusionor,
      ) {
    var value = initialValue;
    iteratingWith(
      another,
          (e, eAnother) => value = e.foldWith(eAnother, value, fusionor),
    );
    return value;
  }
}
extension IntExtension on int {
  int digit({int carry = 10}) {
    int value = abs();
    int d = 0;
    for (var i = 1; i < value; i *= carry, d++) {}
    return d;
  }

  int digitFirst({int carry = 10}) {
    final value = math.pow(carry, digit(carry: carry) - 1).toInt();
    int i = 0;
    for (; value * i < this; i ++) {}
    return i - 1;
  }
}



