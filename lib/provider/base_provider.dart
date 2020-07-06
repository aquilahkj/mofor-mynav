import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

// import 'package:mynav/provider/view_state.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _disposed = false;
  bool _loading = false;

  CompositeSubscription _compositeSubscription = CompositeSubscription();

  /// add [StreamSubscription] to [_compositeSubscription]
  ///
  /// 在 [dispose]的时候能进行取消
  addSubscription(StreamSubscription subscription) {
    _compositeSubscription.add(subscription);
  }

  bool get loading => _loading;

  @protected
  void startLoading() {
    _loading = true;
    notifyListeners();
  }

  @protected
  void endLoading() {
    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    if (!_compositeSubscription.isDisposed) {
      _compositeSubscription.dispose();
    }
    super.dispose();
    _disposed = true;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
