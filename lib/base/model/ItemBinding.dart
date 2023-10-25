import 'package:flutter/cupertino.dart';

class ItemBinding<T> extends ChangeNotifier {
  final T item;
  bool _disposed = false;

  ItemBinding(this.item);

  void update() {
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
