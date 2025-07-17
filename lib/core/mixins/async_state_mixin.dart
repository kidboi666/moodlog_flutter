import 'package:flutter/foundation.dart';

mixin AsyncStateMixin on ChangeNotifier {
  bool _isLoading = false;
  Object? _error;

  bool get isLoading => _isLoading;

  Object? get error => _error;

  bool get hasError => _error != null;

  void setLoading() {
    _isLoading = true;
    _error = null;
    notifyListeners();
  }

  void setSuccess() {
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  void setError(Object error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
