import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/ItemBinding.dart';
import '../model/PageResult.dart';
import 'BaseListVM.dart';

abstract class BasePageListVM<T, IB extends ItemBinding<T>>
    extends BaseListVM<T, IB> {
  final RefreshController refreshController;

  BasePageListVM({required this.refreshController});

  @protected
  int _page = 0;

  int get page => _page;

  void onRefresh() async {
    if (_isNotLoading()) {
      _page = initPage();
      var pageResult = await loadData(_page, getPageSize());

      if (!pageResult.success) {
        refreshController.refreshFailed();
      } else {
        refreshController.refreshCompleted();
      }

      refreshData(isClear: true, dataList: pageResult.itemList);
    }
  }

  void onLoadMore() async {
    if (_isNotLoading()) {
      _page++;
      var pageResult = await loadData(_page, getPageSize());

      if (pageResult.success) {
        refreshController.loadFailed();
        if (!pageResult.hasMore) {
          refreshController.loadNoData();
        }
      } else {
        refreshController.loadComplete();
      }

      refreshData(isClear: false, dataList: pageResult.itemList);
    }
  }

  int initPage() {
    return 0;
  }

  int getPageSize() {
    return 10;
  }

  bool _isNotLoading() {
    return !refreshController.isLoading && !refreshController.isRefresh;
  }

  Future<PageResult<T, IB>> loadData(int page, int pageSize);
}
