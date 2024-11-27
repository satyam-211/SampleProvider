import 'package:flutter/widgets.dart';
import 'package:sample_provider/state_management/observable.dart';
import 'package:sample_provider/state_management/sample_provider.dart';

class Consumer<T> extends StatefulWidget {
  final Widget Function(BuildContext context, Observable<T> store) builder;

  const Consumer({
    super.key,
    required this.builder,
  });

  @override
  State<Consumer<T>> createState() => _ConsumerState<T>();
}

class _ConsumerState<T> extends State<Consumer<T>> {
  Observable<T>? observable;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    observable = SampleProvider.of<T>(context);
    observable?.addObserver(_handleObserverChange);
  }

  void _handleObserverChange(T newState) {
    setState(() {});
  }

  @override
  void dispose() {
    observable?.removeObserver(_handleObserverChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, observable!);
  }
}
