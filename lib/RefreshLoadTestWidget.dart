import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/BaseResp.dart';
import 'package:flutter_demo/base/model/PageResult.dart';
import 'package:flutter_demo/base/vm/BasePageListVM.dart';

import 'api/TestPageDataApi.dart';
import 'base/ui/page/BaseMultiStatePage.dart';

class RefreshLoadTestWidget extends BaseMultiPage<_RefreshLoadTestVM> {
  RefreshLoadTestWidget({super.key}) : super(viewModel: _RefreshLoadTestVM());

  @override
  State<StatefulWidget> createState() => _RefreshLoadTestWidgetState();
}

class _RefreshLoadTestWidgetState extends BaseMultiPageState<
    _RefreshLoadTestVM, RefreshLoadTestWidget> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _RefreshLoadTestVM viewModel) {
    return viewModel.listRefreshBuilder(onItemClick: (item, context) {
      item.item.clickNum = item.item.clickNum + 1;
      item.refresh();
    }, childItemBuilder: (item, context) {
      return Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.only(top: 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.item.title ?? "",
                style: const TextStyle(fontSize: 16, color: Color(0xff333333)),
              ),
              Text(
                "点击数: ${item.item.clickNum}",
                style: const TextStyle(fontSize: 12, color: Color(0xff999999)),
              )
            ],
          ));
    });
  }
}

class _RefreshLoadTestVM extends BasePageListVM<TesItem, List<dynamic>> {
  _RefreshLoadTestVM();

  late TestPageDataApi testPageDataApi;

  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "下拉刷新/上拉加载";

    testPageDataApi = createApi(TestPageDataApi());

    firstLoad(multiStateLoading: true);
  }

  @override
  Future<BaseResp<List<dynamic>>> loadData(int page, int pageSize) {
    return testPageDataApi.getTestPageData(page: page);
  }

  @override
  PageResult<TesItem>? createPageResult(BaseResp<List<dynamic>> resp) {
    List<TesItem> itemList = [];
    resp.data?.forEach((item) {
      itemList.add(TesItem(item));
    });
    return PageResult(itemList);
  }
}

class TesItem {
  final dynamic title;
  int clickNum = 0;

  TesItem(this.title);

  @override
  String toString() {
    return "title: $title, clickNum: $clickNum";
  }
}
