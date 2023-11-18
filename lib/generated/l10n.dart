// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome back !`
  String get WelcomeBack {
    return Intl.message(
      'Welcome back !',
      name: 'WelcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get CreateAnAccount {
    return Intl.message(
      'Create an account',
      name: 'CreateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Rat ID`
  String get RatID {
    return Intl.message(
      'Rat ID',
      name: 'RatID',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get ForgotPassword {
    return Intl.message(
      'Forgot Password ?',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your rat ID`
  String get EnterRatID {
    return Intl.message(
      'Enter your rat ID',
      name: 'EnterRatID',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get EnterName {
    return Intl.message(
      'Enter your name',
      name: 'EnterName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get EnterEmail {
    return Intl.message(
      'Enter your email',
      name: 'EnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get EnterPassword {
    return Intl.message(
      'Enter your password',
      name: 'EnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get EnterValidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'EnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid password`
  String get EnterValidPassword {
    return Intl.message(
      'Enter a valid password',
      name: 'EnterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid name`
  String get EnterValidName {
    return Intl.message(
      'Enter a valid name',
      name: 'EnterValidName',
      desc: '',
      args: [],
    );
  }

  /// `Not a member ?`
  String get NotAMember {
    return Intl.message(
      'Not a member ?',
      name: 'NotAMember',
      desc: '',
      args: [],
    );
  }

  /// `Already a member ?`
  String get AlreadyMember {
    return Intl.message(
      'Already a member ?',
      name: 'AlreadyMember',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `For you`
  String get ForYou {
    return Intl.message(
      'For you',
      name: 'ForYou',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get Chat {
    return Intl.message(
      'Chat',
      name: 'Chat',
      desc: '',
      args: [],
    );
  }

  /// `Trainer`
  String get Trainer {
    return Intl.message(
      'Trainer',
      name: 'Trainer',
      desc: '',
      args: [],
    );
  }

  /// `Trainee`
  String get Trainee {
    return Intl.message(
      'Trainee',
      name: 'Trainee',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get SendEmail {
    return Intl.message(
      'Send Email',
      name: 'SendEmail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
