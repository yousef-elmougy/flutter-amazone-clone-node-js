import 'exports.dart';

/* 
ipconfig

#.*\n
//.*\n

 */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await initGetIt();
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<UserCubit>()),
          BlocProvider(create: (_) => sl<AdminCubit>()),
          BlocProvider(create: (_) => sl<HomeCubit>()),
          BlocProvider(create: (_) => sl<CartCubit>()),
          BlocProvider(create: (_) => sl<AccountCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: kPrimaryColor,
            colorScheme: const ColorScheme.light(
              primary: kSecondaryColor,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            // useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      );
}
