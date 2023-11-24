import 'package:flutter/material.dart';
import 'package:flutter_demo/event/TestEvent.dart';
import 'package:flutter_demo/model/Event1.dart';
import 'package:flutter_demo/page/event/EventPage2.dart';
import 'package:yxr_flutter_basic/base/extension/BuildContextExtension.dart';
import 'package:yxr_flutter_basic/base/model/controller/SimpleGetxController.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/SimpleWidget.dart';
import 'package:yxr_flutter_basic/base/util/GetBuilderUtil.dart';
import 'package:yxr_flutter_basic/base/util/Log.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

/// LiveEvent示例，LiveEvent绑定了生命周期，在Page销毁之后将无法再接收到消息，无需自己管理事件的生命周期
/// 结合EventPage1 + EventPage2 示例实验可以发现
/// page2消息的消息可以传达到page1和page2
/// page2销毁之后回到page1，page1发送的消息在page2已经接收不到了
class EventPage1 extends BaseMultiPage {
  EventPage1({super.key});

  @override
  State<BaseMultiPage> createState() => _Event1State();
}

class _Event1State extends BaseMultiPageState<_Event1VM, EventPage1> {
  @override
  Widget createMultiContentWidget(BuildContext context, _Event1VM viewModel) {
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
        const Padding(padding: EdgeInsets.only(top: 32)),
        SimpleWidget(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          onTap: () {
            context.push(EventPage2());
          },
          child: const Text(
            "跳转到Event2",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        )
      ],
    );
  }

  @override
  _Event1VM createViewModel() => _Event1VM();

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
  String _randomStr() => "{来自Event1-----${DateTime.now().toString()}}";
}

class _Event1VM extends BaseMultiVM {
  SimpleGetxController<Event1> event1Controller = SimpleGetxController();
  SimpleGetxController<String> event2Controller = SimpleGetxController();

  @override
  void onCreate() {
    super.onCreate();

    appbarController.appbarTitle = "LiveEvent示例1";

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
