import 'package:flutter/cupertino.dart';
import 'package:sample_provider/state_management/observable.dart';

class SampleProvider<T> extends InheritedWidget {
  final Observable<T> observable;

  const SampleProvider({
    super.key,
    required super.child,
    required this.observable,
  });

  static Observable<T> of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SampleProvider<T>>()!
        .observable;
  }

  @override
  bool updateShouldNotify(SampleProvider<T> oldWidget) {
    return observable != oldWidget.observable;
  }
}
