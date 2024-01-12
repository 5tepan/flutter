import 'package:flutter/material.dart';

abstract class BaseModel<T> extends ChangeNotifier {
  final T _api;
  bool _loading = false;
  String _error = '';

  BaseModel(this._api);

  bool get loading => _loading;
  String get error => _error;
  T get api => _api;

  void setLoading(bool value) {
    _loading = value;
  }

  void setError(String errorMessage) {
    _error = errorMessage;
  }

  Future<void> loadData();
}
