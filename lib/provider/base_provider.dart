import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mynav/utils/log_utils.dart';
import 'package:rxdart/rxdart.dart';

// typedef ErrorCallback = void Function(dynamic);
// typedef SuccessCallback = void Function();
// typedef DoneCallback = void Function();

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

  @protected
  void process<T>(Stream<T> stream, Function(T) onData,
      {Function onSuccess, Function onDone, Function(dynamic) onError}) {
    startLoading();
    final sub = stream.listen((data) {
      if (onSuccess != null) {
        onSuccess();
      }
      if (onData != null) {
        onData(data);
      }
    }, onDone: () {
      endLoading();
      if (onDone != null) {
        onDone();
      }
    }, onError: (e, s) {
      LogUtils.es(e, stack: s);
      if (onError != null) {
        onError(e);
      }
    });
    addSubscription(sub);
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
