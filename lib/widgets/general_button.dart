import 'package:flutter/material.dart';
import 'package:mynav/res/resources.dart';
import 'package:mynav/utils/theme_utils.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    Key key,
    this.text = '',
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemeUtils.isDark(context);
    return FlatButton(
      onPressed: onPressed,
      textColor: isDark ? Colours.dark_button_text : Colours.button_text,
      color: isDark ? Colours.dark_app_main : Colours.app_main,
      disabledTextColor:
          isDark ? Colours.dark_text_disabled : Colours.text_disabled,
      disabledColor:
          isDark ? Colours.dark_button_disabled : Colours.button_disabled,
      //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: Dimens.font_sp18),
        ),
      ),
    );
  }
}
