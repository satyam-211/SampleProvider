class Observable<T> {
  T _value;

  final List<Function(T)> _observers = [];

  Observable(this._value);

  T get value => _value;

  void setValue(T newValue) {
    _value = newValue;
    for (final observer in _observers) {
      observer(value);
    }
  }

  void addObserver(Function(T) observer) {
    _observers.add(observer);
  }

  void removeObserver(Function(T) observer) {
    _observers.remove(observer);
  }
}
