import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/BaseResp.dart';

import '../model/PageResult.dart';
import 'BaseListVM.dart';

abstract class BasePageListVM<T, E> extends BaseListVM<T> {
  final EasyRefreshController refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  bool _loading = false;

  @protected
  int _page = 0;

  int get page => _page;

  @override
  void onRetry() {
    firstLoad();
  }

  void firstLoad(
      {bool? multiStateLoading, bool? dialogLoading, String? loadingTxt}) {
    _page = initPage();
    if (multiStateLoading == true) {
      showLoadingState(loadingTxt: loadingTxt);
    }
    if (dialogLoading == true) {
      showLoading(loadingTxt: loadingTxt);
    }
    loadData(_page, getPageSize()).then(
        (resp) => {
              _checkUpdateResp(resp, true,
                  first: true,
                  multiStateLoading: multiStateLoading,
                  dialogLoading: dialogLoading)
            }, onError: (e) {
      _refreshLoadFailed(true,
          first: true,
          multiStateLoading: multiStateLoading,
          dialogLoading: dialogLoading);
      if (!isFinishing()) {}
    }).catchError((e) {
      return e;
    });
  }

  void onRefresh() async {
    _refreshLoadData(true);
  }

  void onLoadMore() async {
    _refreshLoadData(false);
  }

  int initPage() {
    return 0;
  }

  int getPageSize() {
    return 10;
  }

  EasyRefresh listRefreshBuilder(
      {required ChildItemBuilder<T> childItemBuilder,
      OnItemClick<T>? onItemClick,
      Widget? listWidget}) {
    return EasyRefresh(
        controller: refreshController,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        canRefreshAfterNoMore: true,
        resetAfterRefresh: true,
        onRefresh: () => onRefresh(),
        onLoad: () => onLoadMore(),
        child: listWidget ??
            listBuilder(
              childItemBuilder: childItemBuilder,
              onItemClick: onItemClick,
            ));
  }

  EasyRefresh gridRefreshBuilder(
      {required ChildItemBuilder<T> childItemBuilder,
      required SliverGridDelegate gridDelegate,
      OnItemClick<T>? onItemClick,
      Widget? gridWidget}) {
    return EasyRefresh(
        controller: refreshController,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        canRefreshAfterNoMore: true,
        resetAfterRefresh: true,
        onRefresh: () => onRefresh(),
        onLoad: () => onLoadMore(),
        child: gridWidget ??
            gridBuilder(
              gridDelegate: gridDelegate,
              childItemBuilder: childItemBuilder,
              onItemClick: onItemClick,
            ));
  }

  void _refreshLoadData(bool isRefresh) async {
    if (_isNotLoading()) {
      if (isRefresh) {
        _page = initPage();
      }

      var resp = await loadData(_page, getPageSize());
      _checkUpdateResp(resp, isRefresh);
    }
  }

  void _checkUpdateResp(BaseResp<E> resp, bool isRefresh,
      {bool first = false, bool? multiStateLoading, bool? dialogLoading}) {
    if (!isFinishing()) {
      if (!resp.isSuccess) {
        _refreshLoadFailed(isRefresh);
      } else {
        var pageResult = createPageResult(resp);
        var itemList = pageResult?.itemList ?? <T>[];
        var hasMore = pageResult?.hasMore ?? itemList.isNotEmpty;

        _refreshLoadSuccess(isRefresh, hasMore, itemList,
            first: first,
            multiStateLoading: multiStateLoading,
            dialogLoading: dialogLoading);
      }
    }
  }

  void _refreshLoadSuccess(bool isRefresh, bool hasMore, List<T> itemList,
      {bool first = false, bool? multiStateLoading, bool? dialogLoading}) {
    if (!isFinishing()) {
      _page++;
      if (isRefresh) {
        refreshController.finishRefresh();
        refreshController.resetFooter();
      } else if (hasMore) {
        refreshController.finishLoad();
      } else {
        refreshController.finishLoad(IndicatorResult.noMore);
      }
      refreshData(isClear: isRefresh, dataList: itemList);

      if (first) {
        if (multiStateLoading == true) {
          showContentState();
        }
        if (dialogLoading == true) {
          dismissLoading();
        }
      }
      _loading = false;
    }
  }

  void _refreshLoadFailed(bool isRefresh,
      {bool first = false, bool? multiStateLoading, bool? dialogLoading}) {
    if (!isFinishing()) {
      if (isRefresh) {
        refreshController.finishRefresh(IndicatorResult.fail);
      } else {
        refreshController.finishLoad(IndicatorResult.fail);
      }
      if (first) {
        if (multiStateLoading == true) {
          showErrorState();
        }
        if (dialogLoading == true) {
          dismissLoading();
        }
      }
      _loading = false;
    }
  }

  bool _isNotLoading() {
    return !_loading;
  }

  @protected
  Future<BaseResp<E>> loadData(int page, int pageSize);

  @protected
  PageResult<T>? createPageResult(BaseResp<E> resp);
}
