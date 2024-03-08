import 'package:quantum_muscle/library.dart';

void main() async {
  if (kIsWeb) setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox<String>('localization');
  if (Hive.box<String>('localization').isEmpty) {
    await Hive.box<String>('localization').put('locale', 'en');
  }
  runApp(const ProviderScope(child: MyApp()));
}

/////! 1. Renew a splash screen
/////! 2. Add shimmer loaders
/////! 3. Add expandable content
//! 4. Add a notifications functionality
/////! 5. Add Analytics
/////! 6. Remove all firebase exeptions
/////! 7. Remove all image widgets and replace them with QmImage
//! 8. Add content index scrolling
/////! 9. Change all consumer objects to _, ref,__
/////! 9. Fix delete workout in program
//! 10. Add a new workouts
//! 11. Capture the images for Commercial use

/// The main application widget.
class MyApp extends ConsumerWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: Locale(locale.locale),
      theme: ThemeController.theme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        ],
      ),
      routerConfig: RoutingController.router,
    );
  }
}

/*
flutter clean && flutter pub get && clear
&& flutter build web --release --web-renderer html && firebase deploy
*/

/// A theme for page transitions.
class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (kIsWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// Utility class for managing workouts.
final workoutUtil = WorkoutUtil();

/// Utility class for managing programs.
final programUtil = ProgramUtil();

/// Utility class for managing exercises.
final exerciseUtil = ExerciseUtil();

/// Utility class for managing users.
final userUtil = UserUtil();

/// General utility class.
final utils = Utils();

/// Utility class for managing login functionality.
final loginUtil = LoginUtil();

/// Utility class for managing logout functionality.
final logoutUtil = LogoutUtil();

/// Utility class for managing user registration.
final registerUtil = RegisterUtil();

/// Utility class for managing password recovery.
final forgetPasswordUtil = ForgetPasswordUtil();

/// Utility class for managing user profiles.
final profileUtil = ProfileUtil();

/// Utility class for managing chat functionality.
final chatUtil = ChatUtil();
