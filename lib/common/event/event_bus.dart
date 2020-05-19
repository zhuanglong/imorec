// 订阅者回调签名
typedef void EventCallback(args);

class EventBus {
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static EventBus singleton = EventBus._internal();

  // 工厂构造函数
  factory EventBus() => singleton;

  // 保存事件订阅者队列
  var emap = Map<Object, List<EventCallback>>();

  // 添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null && f == null) return;
    emap[eventName] ??= List<EventCallback>();
    emap[eventName].add(f);
  }

  // 移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = emap[eventName];
    if (eventName == null && list == null) return;
    if (f == null) {
      emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  // 触发事件
  void emit(eventName, [arg]) {
    var list = emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    // 反向遍历，防止在订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var eventBus = EventBus();