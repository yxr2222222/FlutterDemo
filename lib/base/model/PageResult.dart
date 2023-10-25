import 'ItemBinding.dart';

class PageResult<T, IB extends ItemBinding<T>> {
  final bool success;
  final bool hasMore;
  final List<IB> itemList;

  PageResult(this.success, this.hasMore, this.itemList);
}
