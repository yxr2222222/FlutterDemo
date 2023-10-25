import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/ItemBinding.dart';

abstract class ItemWidget<T, IB extends ItemBinding<T>>
    extends StatelessWidget {
  final IB itemBinding;
  final Widget child;

  const ItemWidget(this.itemBinding, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => itemBinding,
      child: Consumer<IB>(
          builder: (BuildContext context, IB itemBinding, Widget? child) =>
              this.child),
    );
  }
}
