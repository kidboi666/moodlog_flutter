import 'package:flutter/foundation.dart';

import '../constants/enum.dart';

mixin AsyncStateMixin on ChangeNotifier {
  AsyncState _state = AsyncState.idle;
  Object? _error;

  AsyncState get state => _state;

  bool get isIdle => _state == AsyncState.idle;

  bool get isLoading => _state == AsyncState.loading;

  Object? get error => _error;

  bool get hasError => _state == AsyncState.error;

  void setAsyncState([AsyncState newState = AsyncState.idle, Object? error]) {
    _state = newState;
    _error = error;
    notifyListeners();
  }

  void setLoading() {
    if (_state == AsyncState.loading) return;
    _state = AsyncState.loading;
    _error = null;
    notifyListeners();
  }

  void setSuccess() {
    if (_state == AsyncState.success && _error == null) return;
    _state = AsyncState.success;
    _error = null;
    notifyListeners();
  }

  void setError(Object error) {
    if (_state == AsyncState.error && _error == error) return;
    _state = AsyncState.error;
    _error = error;
    notifyListeners();
  }

  void clearState() {
    if (_state == AsyncState.idle && _error == null) return;
    _error = null;
    _state = AsyncState.idle;
    notifyListeners();
  }
}
