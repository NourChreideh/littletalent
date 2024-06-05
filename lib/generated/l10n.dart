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

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `please Login with your Phone Number`
  String get loginsentence {
    return Intl.message(
      'please Login with your Phone Number',
      name: 'loginsentence',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get singin {
    return Intl.message(
      'Sign In',
      name: 'singin',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid Services`
  String get unpaid {
    return Intl.message(
      'Unpaid Services',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Children`
  String get children {
    return Intl.message(
      'Children',
      name: 'children',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signout {
    return Intl.message(
      'Sign Out',
      name: 'signout',
      desc: '',
      args: [],
    );
  }

  /// `All Notifications`
  String get allnotifications {
    return Intl.message(
      'All Notifications',
      name: 'allnotifications',
      desc: '',
      args: [],
    );
  }

  /// `Check-in`
  String get checkin {
    return Intl.message(
      'Check-in',
      name: 'checkin',
      desc: '',
      args: [],
    );
  }

  /// `Check-out`
  String get checkout {
    return Intl.message(
      'Check-out',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get inbox {
    return Intl.message(
      'Inbox',
      name: 'inbox',
      desc: '',
      args: [],
    );
  }

  /// `Center`
  String get center {
    return Intl.message(
      'Center',
      name: 'center',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Meals taken`
  String get mealstaken {
    return Intl.message(
      'Meals taken',
      name: 'mealstaken',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get daysago {
    return Intl.message(
      'days ago',
      name: 'daysago',
      desc: '',
      args: [],
    );
  }

  /// `Meals`
  String get meals {
    return Intl.message(
      'Meals',
      name: 'meals',
      desc: '',
      args: [],
    );
  }

  /// `Attendance`
  String get attendance {
    return Intl.message(
      'Attendance',
      name: 'attendance',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `Diapers`
  String get diapers {
    return Intl.message(
      'Diapers',
      name: 'diapers',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get adress {
    return Intl.message(
      'Address',
      name: 'adress',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get contactinfo {
    return Intl.message(
      'Contact information',
      name: 'contactinfo',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `updated by system`
  String get updatedbysystem {
    return Intl.message(
      'updated by system',
      name: 'updatedbysystem',
      desc: '',
      args: [],
    );
  }

  /// `Activities`
  String get activities {
    return Intl.message(
      'Activities',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phonenumber {
    return Intl.message(
      'Phone Number',
      name: 'phonenumber',
      desc: '',
      args: [],
    );
  }

  /// `My Children`
  String get MyChildren {
    return Intl.message(
      'My Children',
      name: 'MyChildren',
      desc: '',
      args: [],
    );
  }

  /// `Sleeping`
  String get sleeping {
    return Intl.message(
      'Sleeping',
      name: 'sleeping',
      desc: '',
      args: [],
    );
  }

  /// `Shhh... Baby is Sleeping `
  String get shhhh {
    return Intl.message(
      'Shhh... Baby is Sleeping ',
      name: 'shhhh',
      desc: '',
      args: [],
    );
  }

  /// ` is Sleeping  from  `
  String get isSleeping {
    return Intl.message(
      ' is Sleeping  from  ',
      name: 'isSleeping',
      desc: '',
      args: [],
    );
  }

  /// `to `
  String get to {
    return Intl.message(
      'to ',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `No Record Yet `
  String get noRecord {
    return Intl.message(
      'No Record Yet ',
      name: 'noRecord',
      desc: '',
      args: [],
    );
  }

  /// `No Activites Yet`
  String get noactivities {
    return Intl.message(
      'No Activites Yet',
      name: 'noactivities',
      desc: '',
      args: [],
    );
  }

  /// `Here is the list of activities that`
  String get Hereis {
    return Intl.message(
      'Here is the list of activities that',
      name: 'Hereis',
      desc: '',
      args: [],
    );
  }

  /// `participated in during their time at the center`
  String get Participated {
    return Intl.message(
      'participated in during their time at the center',
      name: 'Participated',
      desc: '',
      args: [],
    );
  }

  /// `by System at`
  String get bysystem {
    return Intl.message(
      'by System at',
      name: 'bysystem',
      desc: '',
      args: [],
    );
  }

  /// `At`
  String get At {
    return Intl.message(
      'At',
      name: 'At',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the changing station, Where miracles happen, one wipe at a time.`
  String get welcometothe {
    return Intl.message(
      'Welcome to the changing station, Where miracles happen, one wipe at a time.',
      name: 'welcometothe',
      desc: '',
      args: [],
    );
  }

  /// `today and we took the necessary measures.`
  String get todaywetook {
    return Intl.message(
      'today and we took the necessary measures.',
      name: 'todaywetook',
      desc: '',
      args: [],
    );
  }

  /// `Daily Check`
  String get dailycheck {
    return Intl.message(
      'Daily Check',
      name: 'dailycheck',
      desc: '',
      args: [],
    );
  }

  /// `We completed a health check-up today for `
  String get wecompleted {
    return Intl.message(
      'We completed a health check-up today for ',
      name: 'wecompleted',
      desc: '',
      args: [],
    );
  }

  /// `and we have the details here.`
  String get andwehave {
    return Intl.message(
      'and we have the details here.',
      name: 'andwehave',
      desc: '',
      args: [],
    );
  }

  /// `Daily Services`
  String get dailyservices {
    return Intl.message(
      'Daily Services',
      name: 'dailyservices',
      desc: '',
      args: [],
    );
  }

  /// `Daily Activities`
  String get dailyactivities {
    return Intl.message(
      'Daily Activities',
      name: 'dailyactivities',
      desc: '',
      args: [],
    );
  }

  /// `you'r second home `
  String get yoursecondhome {
    return Intl.message(
      'you\'r second home ',
      name: 'yoursecondhome',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Check-In / Check-Out`
  String get checkess {
    return Intl.message(
      'Check-In / Check-Out',
      name: 'checkess',
      desc: '',
      args: [],
    );
  }

  /// `today.`
  String get todays {
    return Intl.message(
      'today.',
      name: 'todays',
      desc: '',
      args: [],
    );
  }

  /// `really enjoyed `
  String get reallyEnjoyed {
    return Intl.message(
      'really enjoyed ',
      name: 'reallyEnjoyed',
      desc: '',
      args: [],
    );
  }

  /// `No meal taken yet`
  String get nomealtaken {
    return Intl.message(
      'No meal taken yet',
      name: 'nomealtaken',
      desc: '',
      args: [],
    );
  }

  /// `I want to give you a quick update on `
  String get iwant {
    return Intl.message(
      'I want to give you a quick update on ',
      name: 'iwant',
      desc: '',
      args: [],
    );
  }

  /// ` meals today at the nursery.`
  String get mealstoday {
    return Intl.message(
      ' meals today at the nursery.',
      name: 'mealstoday',
      desc: '',
      args: [],
    );
  }

  /// `Let us know which language you’re most comfortable using on App. You can change it back at any time.`
  String get letUs {
    return Intl.message(
      'Let us know which language you’re most comfortable using on App. You can change it back at any time.',
      name: 'letUs',
      desc: '',
      args: [],
    );
  }

  /// `Select the language you use`
  String get selectthe {
    return Intl.message(
      'Select the language you use',
      name: 'selectthe',
      desc: '',
      args: [],
    );
  }

  /// `Camera Feed`
  String get cameraFeed {
    return Intl.message(
      'Camera Feed',
      name: 'cameraFeed',
      desc: '',
      args: [],
    );
  }

  /// `Stay close from your kids`
  String get stayclose {
    return Intl.message(
      'Stay close from your kids',
      name: 'stayclose',
      desc: '',
      args: [],
    );
  }

  /// `Live from their classroom`
  String get livefrom {
    return Intl.message(
      'Live from their classroom',
      name: 'livefrom',
      desc: '',
      args: [],
    );
  }

  /// `Money`
  String get Money {
    return Intl.message(
      'Money',
      name: 'Money',
      desc: '',
      args: [],
    );
  }

  /// `Center Closing`
  String get CenterClosing {
    return Intl.message(
      'Center Closing',
      name: 'CenterClosing',
      desc: '',
      args: [],
    );
  }

  /// `Saturday and Sunday`
  String get SaturdayandSunday {
    return Intl.message(
      'Saturday and Sunday',
      name: 'SaturdayandSunday',
      desc: '',
      args: [],
    );
  }

  /// `Friday:`
  String get Fridays {
    return Intl.message(
      'Friday:',
      name: 'Fridays',
      desc: '',
      args: [],
    );
  }

  /// `Thursday:`
  String get Thursdays {
    return Intl.message(
      'Thursday:',
      name: 'Thursdays',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday:`
  String get Wednesdays {
    return Intl.message(
      'Wednesday:',
      name: 'Wednesdays',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday:`
  String get Tuesdays {
    return Intl.message(
      'Tuesday:',
      name: 'Tuesdays',
      desc: '',
      args: [],
    );
  }

  /// `Monday:`
  String get Mondays {
    return Intl.message(
      'Monday:',
      name: 'Mondays',
      desc: '',
      args: [],
    );
  }

  /// `Operating hours`
  String get Operatinghours {
    return Intl.message(
      'Operating hours',
      name: 'Operatinghours',
      desc: '',
      args: [],
    );
  }

  /// `Child Care Service`
  String get ChildCareService {
    return Intl.message(
      'Child Care Service',
      name: 'ChildCareService',
      desc: '',
      args: [],
    );
  }

  /// `Cash Receipt`
  String get CashReceipt {
    return Intl.message(
      'Cash Receipt',
      name: 'CashReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Click here`
  String get Clickhere {
    return Intl.message(
      'Click here',
      name: 'Clickhere',
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
      Locale.fromSubtags(languageCode: 'fr'),
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
