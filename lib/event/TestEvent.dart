import 'package:flutter_demo/model/Event1.dart';
import 'package:yxr_flutter_basic/base/event/EventOb.dart';
import 'package:yxr_flutter_basic/base/event/LiveEventCore.dart';

class TestEvent {
  static const String _event_1 = "event_1";
  static const String _event_2 = "event_2";

  TestEvent._();

  static void postEvent1(Event1 event1) {
    getEvent1().postEvent(event1);
  }

  static EventObservable<Event1> getEvent1() => LiveEventCore.getEvent(_event_1);

  static void postEvent2(String event2) {
    getEvent2().postEvent(event2);
  }

  static EventObservable<String> getEvent2() => LiveEventCore.getEvent(_event_2);
}
