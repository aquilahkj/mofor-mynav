import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynav/localization/app_localizations.dart';
import 'package:mynav/res/resources.dart';

import 'load_image.dart';

/// 登录模块的输入框封装
class InputTextField extends StatefulWidget {
  const InputTextField(
      {Key key,
      @required this.controller,
      this.maxLength = 16,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.focusNode,
      this.isInputPwd = false,
      this.keyName})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;

  /// 用于集成测试寻找widget
  final String keyName;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;

  @override
  void initState() {
    super.initState();

    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
  }

  void isEmpty() {
    bool isEmpty = widget.controller.text.isEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final TextField textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd ? !_isShowPwd : false,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
      inputFormatters: (widget.keyboardType == TextInputType.number ||
              widget.keyboardType == TextInputType.phone)
          ? [WhitelistingTextInputFormatter(RegExp('[0-9]'))]
          : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeData.primaryColor,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeData.dividerTheme.color,
            width: 0.8,
          ),
        ),
      ),
    );

    Widget clear = Semantics(
      label: AppLocalizations.of(context).clear,
      hint: AppLocalizations.of(context).clearInputField,
      child: GestureDetector(
        child: LoadAssetImage(
          'ic_text_delete',
          key: Key('${widget.keyName}_delete'),
          width: 18.0,
          height: 40.0,
        ),
        onTap: () => widget.controller.text = '',
      ),
    );

    Widget pwdVisible = Semantics(
      label: AppLocalizations.of(context).passwordVisibleSwitch,
      hint: AppLocalizations.of(context).passwordIsVisible,
      child: GestureDetector(
        child: LoadAssetImage(
          _isShowPwd ? 'ic_pwd_display' : 'ic_pwd_hide',
          key: Key('${widget.keyName}_showPwd'),
          width: 18.0,
          height: 40.0,
        ),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      ),
    );

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_isShowDelete) Gaps.empty else clear,
            if (!widget.isInputPwd) Gaps.empty else Gaps.hGap15,
            if (!widget.isInputPwd) Gaps.empty else pwdVisible,
          ],
        )
      ],
    );
  }
}
