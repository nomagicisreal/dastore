///
///
/// this file contains:
/// [IconAction]
///
/// [IterableIconAction]
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
}