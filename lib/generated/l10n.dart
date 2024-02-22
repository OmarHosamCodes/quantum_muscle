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

  /// `Enter your new bio`
  String get Bio {
    return Intl.message(
      'Enter your new bio',
      name: 'Bio',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get Height {
    return Intl.message(
      'Height',
      name: 'Height',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get Age {
    return Intl.message(
      'Age',
      name: 'Age',
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

  /// `Enter a valid bio`
  String get EnterValidBio {
    return Intl.message(
      'Enter a valid bio',
      name: 'EnterValidBio',
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

  /// `No chats yet`
  String get NoChat {
    return Intl.message(
      'No chats yet',
      name: 'NoChat',
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

  /// `Trainees:`
  String get Trainees {
    return Intl.message(
      'Trainees:',
      name: 'Trainees',
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

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Start Making Difference`
  String get Slogan {
    return Intl.message(
      'Start Making Difference',
      name: 'Slogan',
      desc: '',
      args: [],
    );
  }

  /// `Workouts:`
  String get Workouts {
    return Intl.message(
      'Workouts:',
      name: 'Workouts',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get Followers {
    return Intl.message(
      'Followers',
      name: 'Followers',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get Following {
    return Intl.message(
      'Following',
      name: 'Following',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get EditProfile {
    return Intl.message(
      'Edit Profile',
      name: 'EditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get Likes {
    return Intl.message(
      'Likes',
      name: 'Likes',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get Comments {
    return Intl.message(
      'Comments',
      name: 'Comments',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get Add {
    return Intl.message(
      'Add',
      name: 'Add',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Description {
    return Intl.message(
      'Description',
      name: 'Description',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message(
      'Success',
      name: 'Success',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get Failed {
    return Intl.message(
      'Failed',
      name: 'Failed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again later`
  String get DefaultError {
    return Intl.message(
      'Something went wrong, please try again later',
      name: 'DefaultError',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get Language {
    return Intl.message(
      'English',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get TryAgain {
    return Intl.message(
      'Try Again',
      name: 'TryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Target`
  String get Target {
    return Intl.message(
      'Target',
      name: 'Target',
      desc: '',
      args: [],
    );
  }

  /// `Email sent successfully`
  String get EmailSentSuccessfully {
    return Intl.message(
      'Email sent successfully',
      name: 'EmailSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Go back to login`
  String get GoBackToLogin {
    return Intl.message(
      'Go back to login',
      name: 'GoBackToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Let people know who you are`
  String get LetPeopleKnow {
    return Intl.message(
      'Let people know who you are',
      name: 'LetPeopleKnow',
      desc: '',
      args: [],
    );
  }

  /// `No bio`
  String get NoBio {
    return Intl.message(
      'No bio',
      name: 'NoBio',
      desc: '',
      args: [],
    );
  }

  /// `Profile does not exist`
  String get ProfileDoesNotExist {
    return Intl.message(
      'Profile does not exist',
      name: 'ProfileDoesNotExist',
      desc: '',
      args: [],
    );
  }

  /// `You already have a chat with this user`
  String get YouAlreadyHaveAChatWithThisUser {
    return Intl.message(
      'You already have a chat with this user',
      name: 'YouAlreadyHaveAChatWithThisUser',
      desc: '',
      args: [],
    );
  }

  /// `just now`
  String get JustNow {
    return Intl.message(
      'just now',
      name: 'JustNow',
      desc: '',
      args: [],
    );
  }

  /// `minutes ago`
  String get MinutesAgo {
    return Intl.message(
      'minutes ago',
      name: 'MinutesAgo',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get DaysAgo {
    return Intl.message(
      'days ago',
      name: 'DaysAgo',
      desc: '',
      args: [],
    );
  }

  /// `hours ago`
  String get HoursAgo {
    return Intl.message(
      'hours ago',
      name: 'HoursAgo',
      desc: '',
      args: [],
    );
  }

  /// `weeks ago`
  String get WeeksAgo {
    return Intl.message(
      'weeks ago',
      name: 'WeeksAgo',
      desc: '',
      args: [],
    );
  }

  /// `months ago`
  String get MonthsAgo {
    return Intl.message(
      'months ago',
      name: 'MonthsAgo',
      desc: '',
      args: [],
    );
  }

  /// `years ago`
  String get YearsAgo {
    return Intl.message(
      'years ago',
      name: 'YearsAgo',
      desc: '',
      args: [],
    );
  }

  /// `minute ago`
  String get MinuteAgo {
    return Intl.message(
      'minute ago',
      name: 'MinuteAgo',
      desc: '',
      args: [],
    );
  }

  /// `hour ago`
  String get HourAgo {
    return Intl.message(
      'hour ago',
      name: 'HourAgo',
      desc: '',
      args: [],
    );
  }

  /// `week ago`
  String get WeekAgo {
    return Intl.message(
      'week ago',
      name: 'WeekAgo',
      desc: '',
      args: [],
    );
  }

  /// `day ago`
  String get DayAgo {
    return Intl.message(
      'day ago',
      name: 'DayAgo',
      desc: '',
      args: [],
    );
  }

  /// `month ago`
  String get MonthAgo {
    return Intl.message(
      'month ago',
      name: 'MonthAgo',
      desc: '',
      args: [],
    );
  }

  /// `year ago`
  String get YearAgo {
    return Intl.message(
      'year ago',
      name: 'YearAgo',
      desc: '',
      args: [],
    );
  }

  /// `Type a message...`
  String get TypeMessage {
    return Intl.message(
      'Type a message...',
      name: 'TypeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Programs`
  String get Programs {
    return Intl.message(
      'Programs',
      name: 'Programs',
      desc: '',
      args: [],
    );
  }

  /// `No programs yet`
  String get NoPrograms {
    return Intl.message(
      'No programs yet',
      name: 'NoPrograms',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get SendRequest {
    return Intl.message(
      'Send Request',
      name: 'SendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Add Trainee ID`
  String get AddTraineeId {
    return Intl.message(
      'Add Trainee ID',
      name: 'AddTraineeId',
      desc: '',
      args: [],
    );
  }

  /// `Will you join this program ?`
  String get WillYouJoinProgram {
    return Intl.message(
      'Will you join this program ?',
      name: 'WillYouJoinProgram',
      desc: '',
      args: [],
    );
  }

  /// `Workout already exists in program`
  String get WorkoutAlreadyExistsInProgram {
    return Intl.message(
      'Workout already exists in program',
      name: 'WorkoutAlreadyExistsInProgram',
      desc: '',
      args: [],
    );
  }

  /// `Total Workouts`
  String get TotalWorkouts {
    return Intl.message(
      'Total Workouts',
      name: 'TotalWorkouts',
      desc: '',
      args: [],
    );
  }

  /// `Total Exercises`
  String get TotalExercises {
    return Intl.message(
      'Total Exercises',
      name: 'TotalExercises',
      desc: '',
      args: [],
    );
  }

  /// `Total Programs`
  String get TotalPrograms {
    return Intl.message(
      'Total Programs',
      name: 'TotalPrograms',
      desc: '',
      args: [],
    );
  }

  /// `Total Clients`
  String get TotalClients {
    return Intl.message(
      'Total Clients',
      name: 'TotalClients',
      desc: '',
      args: [],
    );
  }

  /// `Total Followers`
  String get TotalFollowers {
    return Intl.message(
      'Total Followers',
      name: 'TotalFollowers',
      desc: '',
      args: [],
    );
  }

  /// `Weight x Reps`
  String get WeightXReps {
    return Intl.message(
      'Weight x Reps',
      name: 'WeightXReps',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number`
  String get EnterValidNumber {
    return Intl.message(
      'Enter a valid number',
      name: 'EnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Reps`
  String get Reps {
    return Intl.message(
      'Reps',
      name: 'Reps',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get Weight {
    return Intl.message(
      'Weight',
      name: 'Weight',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get Exercises {
    return Intl.message(
      'Exercises',
      name: 'Exercises',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid description`
  String get EnterValidDescription {
    return Intl.message(
      'Enter a valid description',
      name: 'EnterValidDescription',
      desc: '',
      args: [],
    );
  }

  /// `You reached the limit of programs`
  String get YouReachedTheLimitOfPrograms {
    return Intl.message(
      'You reached the limit of programs',
      name: 'YouReachedTheLimitOfPrograms',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get NetworkError {
    return Intl.message(
      'Network error',
      name: 'NetworkError',
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
