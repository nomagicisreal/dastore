///
///
/// this file contains:
/// [IconAction]
///
/// [IterableIconAction]
///
///
/// [GlobalKeysWidget]
/// [StreamWidget]
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
///
///
///
///
///
///
///
part of dastore;

class IconAction {
  final Icon icon;
  final VoidCallback action;

  const IconAction(this.icon, this.action);

  double dimensionFrom(BuildContext context) =>
      icon.size ?? context.theme.iconTheme.size ?? 24.0;

  Widget buildWith(Mixer<Icon, VoidCallback, Widget> mixer) =>
      mixer(icon, action);
}

extension IterableIconAction on Iterable<IconAction> {
  List<Widget> build(Fusionor<int, Icon, VoidCallback, Widget> fusionor) =>
      foldWithIndex(
        [],
        (index, widgets, iconAction) => widgets
          ..add(iconAction.buildWith(
            (icon, action) => fusionor(index, icon, action),
          )),
      );

  double maxRadiusBy(BuildContext context) {
    final size = context.themeIcon.size ?? 24.0;
    return reduceTo<double>(math.max, (i) => i.icon.size ?? size);
  }
}

///
///
///
/// [GlobalKeysWidget]
///
///
///
class GlobalKeysWidget<S extends State<StatefulWidget>> extends StatefulWidget {
  const GlobalKeysWidget({
    super.key,
    required this.keysName,
    required this.builder,
  });

  final Set<String> keysName;
  final WidgetGlobalKeysBuilder<S> builder;

  static GlobalKey<S> toGlobalKey<S extends State<StatefulWidget>>(
    String key,
  ) =>
      GlobalKey<S>(debugLabel: key);

  @override
  State<GlobalKeysWidget<S>> createState() => _GlobalKeysWidgetState<S>();
}

class _GlobalKeysWidgetState<S extends State<StatefulWidget>>
    extends State<GlobalKeysWidget<S>> {
  final Map<String, GlobalKey<S>> keys = {};

  @override
  void initState() {
    final names = widget.keysName;
    keys.addAll(Map.fromIterables(
      names,
      names.map(GlobalKeysWidget.toGlobalKey),
    ));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GlobalKeysWidget<S> oldWidget) {
    keys.mergeAs(widget.keysName, GlobalKeysWidget.toGlobalKey);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, keys);
}

///
///
/// [StreamWidget]
///
///
class StreamWidget<T> extends StatelessWidget {
  const StreamWidget({
    super.key,
    this.initialData,
    this.waitingDataBuilder,
    this.activeBuilder,
    this.doneConnectBuilder,
    this.noneConnectionBuilder,
    required this.stream,
    required this.builder,
    this.child,
  });

  final T? initialData;
  final Stream<T> stream;
  final ValueWidgetBuilder<T?> builder;
  final ValueWidgetBuilder<T?>? activeBuilder;
  final ValueWidgetBuilder<T?>? waitingDataBuilder;
  final ValueWidgetBuilder<T?>? doneConnectBuilder;
  final ValueWidgetBuilder<T?>? noneConnectionBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw UnimplementedError(snapshot.error.toString());
        }
        final status = snapshot.connectionState;
        return (switch (status) {
              ConnectionState.none => noneConnectionBuilder,
              ConnectionState.waiting => waitingDataBuilder,
              ConnectionState.active => activeBuilder,
              ConnectionState.done => doneConnectBuilder,
            } ??
            this.builder)(context, snapshot.data, child);
      },
    );
  }
}
