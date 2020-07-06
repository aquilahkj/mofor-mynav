// Once you've added a Intl.message get run the commands below to update the generated arb and dart files
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/localization/l10n lib/localization/app_localizations.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/localization/l10n --no-use-deferred-loading lib/localization/app_localizations.dart lib/localization/l10n/intl_*.arb
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Flutter Deer',
      name: 'title',
      desc: 'Title for the application',
      locale: localeName,
    );
  }

  String get verificationCodeLogin {
    return Intl.message(
      'Verification Code Login',
      name: 'verificationCodeLogin',
      desc: 'Title for the Login page',
      locale: localeName
    );
  }

  String get passwordLogin {
    return Intl.message(
      'Password Login',
      name: 'passwordLogin',
      desc: 'Password Login',
      locale: localeName
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login',
      locale: localeName,
    );
  }

  String get forgotPasswordLink {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordLink',
      desc: 'Forgot Password',
      locale: localeName
    );
  }

  String get inputPasswordHint {
    return Intl.message(
      'Please enter the password',
      name: 'inputPasswordHint',
      desc: 'Please enter the password',
      locale: localeName
    );
  }

  String get inputUsernameHint {
    return Intl.message(
      'Please input Username',
      name: 'inputUsernameHint',
      desc: 'Please input Username',
      locale: localeName
    );
  }

  String get noAccountRegisterLink {
    return Intl.message(
      'No account yet? Register now',
      name: 'noAccountRegisterLink',
      desc: 'No account yet? Register now',
      locale: localeName
    );
  }
  
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Register',
      locale: localeName
    );
  }

  String get openYourAccount {
    return Intl.message(
      'Open your account', // 开启你的账号 
      name: 'openYourAccount',
      desc: 'Open your account',
      locale: localeName
    );
  }

  String get inputPhoneHint {
    return Intl.message(
      'Please enter phone number', // 请输入手机号
      name: 'inputPhoneHint',
      desc: 'Please enter phone number',
      locale: localeName
    );
  }

  String get inputVerificationCodeHint {
    return Intl.message(
      'Please enter verification code', // 请输入验证码
      name: 'inputVerificationCodeHint',
      desc: 'Please enter verification code',
      locale: localeName
    );
  }

  String get inputPhoneInvalid {
    return Intl.message(
      'Please input valid mobile phone number', // 请输入有效的手机号
      name: 'inputPhoneInvalid',
      desc: 'Please input valid mobile phone number',
      locale: localeName
    );
  }

  String get verification {
    return Intl.message(
      'Not really sent, just log in!', // 并没有真正发送哦，直接登录吧！
      name: 'verification',
      desc: 'Not really sent, just log in!',
      locale: localeName
    );
  }

  String get getVerificationCode {
    return Intl.message(
        'Get verification code', // 获取验证码
        name: 'getVerificationCode',
        desc: 'Get verification code',
        locale: localeName
    );
  }

  String get clear {
    return Intl.message(
        'Clear', 
        name: 'clear',
        desc: 'Clear',
        locale: localeName
    );
  }

  String get clearInputField {
    return Intl.message(
        'Clear the input field',
        name: 'clearInputField',
        desc: 'Clear the input field',
        locale: localeName
    );
  }

  String get passwordVisibleSwitch {
    return Intl.message(
        'Password Visible Switch', 
        name: 'passwordVisibleSwitch',
        desc: 'Password Visible Switch',
        locale: localeName
    );
  }

  String get passwordIsVisible {
    return Intl.message(
        'Whether password is visible', 
        name: 'passwordVisible',
        desc: 'Whether password is visible',
        locale: localeName
    );
  }
}

