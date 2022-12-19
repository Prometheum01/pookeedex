import 'package:flutter/material.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  changeLoading({bool? newState}) {
    if (newState != null) {
      _isLoading = newState;
    } else {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  bool get isLoading => _isLoading;
}
