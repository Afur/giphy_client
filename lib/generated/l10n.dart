// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Giphy Client`
  String get title {
    return Intl.message(
      'Giphy Client',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `UNSAVE`
  String get unsave {
    return Intl.message(
      'UNSAVE',
      name: 'unsave',
      desc: '',
      args: [],
    );
  }

  /// `SHARE`
  String get share {
    return Intl.message(
      'SHARE',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any saved gifs`
  String get no_saved_gifs {
    return Intl.message(
      'You don\'t have any saved gifs',
      name: 'no_saved_gifs',
      desc: '',
      args: [],
    );
  }

  /// `No gifs was found`
  String get no_gifs_found {
    return Intl.message(
      'No gifs was found',
      name: 'no_gifs_found',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Unable to show past launches`
  String get unable_to_show_launches {
    return Intl.message(
      'Unable to show past launches',
      name: 'unable_to_show_launches',
      desc: '',
      args: [],
    );
  }

  /// `Tap to try again`
  String get tap_to_try_again {
    return Intl.message(
      'Tap to try again',
      name: 'tap_to_try_again',
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
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}