import 'package:flutter/material.dart';
import 'package:flutter_demo/event/TestEvent.dart';
import 'package:flutter_demo/model/Event1.dart';
import 'package:yxr_flutter_basic/base/model/controller/SimpleGetxController.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/SimpleWidget.dart';
import 'package:yxr_flutter_basic/base/util/GetBuilderUtil.dart';
import 'package:yxr_flutter_basic/base/util/Log.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

class EventPage2 extends BaseMultiPage {
  EventPage2({super.key});

  @override
  State<BaseMultiPage> createState() => _Event2State();
}

class _Event2State extends BaseMultiPageState<_Event2VM, EventPage2> {
  @override
  Widget createMultiContentWidget(BuildContext context, _Event2VM viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildEvent1Widget(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        _buildEvent2Widget(),
        const Padding(padding: EdgeInsets.only(top: 32)),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 16)),
            _buildBtn("发生事件1", () {
              /// 发生事件1的消息
              TestEvent.postEvent1(Event1(_randomStr()));
            }),
            const Padding(padding: EdgeInsets.only(left: 48)),
            _buildBtn("发生事件2", () {
              /// 发生事件2的消息
              TestEvent.postEvent2(_randomStr());
            }),
            const Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
      ],
    );
  }

  @override
  _Event2VM createViewModel() => _Event2VM();

  // 构建事件1展示组件
  Widget _buildEvent1Widget() => GetBuilderUtil.builder(
      (controller) => Text(
            "event1: ${controller.data?.data}",
            style: const TextStyle(color: Colors.green),
          ),
      init: viewModel.event1Controller);

  // 构建事件2展示组件
  Widget _buildEvent2Widget() => GetBuilderUtil.builder(
      (controller) => Text(
            "event2: ${controller.data}",
            style: const TextStyle(color: Colors.red),
          ),
      init: viewModel.event2Controller);

  // 构建按钮
  Widget _buildBtn(String title, GestureTapCallback onTap) => Expanded(
          child: SimpleWidget(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ));

  // 生成当前时间作为随机内容
  String _randomStr() => "{Come from event2-----${DateTime.now().toString()}}";
}

class _Event2VM extends BaseMultiVM {
  SimpleGetxController<Event1> event1Controller = SimpleGetxController();
  SimpleGetxController<String> event2Controller = SimpleGetxController();

  @override
  void onCreate() {
    super.onCreate();

    appbarController.appbarTitle = "LiveEvent示例2";

    /// 注册事件一监听，无需关系生命周期，LiveEventCore内部会处理
    TestEvent.getEvent1().observe(pageLifecycle, (event) {
      event1Controller.data = event;
      Log.d("event1: ${event?.data}");
    });

    /// 注册事件二监听，无需关系生命周期，LiveEventCore内部会处理
    TestEvent.getEvent2().observe(pageLifecycle, (event) {
      event2Controller.data = event;
      Log.d("event2: $event");
    });
  }
}
