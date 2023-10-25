import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ItemWidget<T, IB extends ItemBinding<T>>
    extends StatelessWidget {
  final IB itemBinding;
  final int index;

  const ItemWidget(this.itemBinding, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => itemBinding,
      child: Consumer<IB>(
        builder: (BuildContext context, IB itemBinding, Widget? child) =>
            createChild(context, itemBinding, index),
      ),
    );
  }

  Widget createChild(BuildContext context, IB itemBinding, int index);
}

class ItemBinding<T> extends ChangeNotifier {
  final T item;

  ItemBinding(this.item);
}
