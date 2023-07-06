



import 'exports.dart';

GetIt sl = GetIt.instance;

Future<void> initGetIt() async {
  /// cubit

  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => UserCubit(sl())..getUser());
  sl.registerFactory(() => AdminCubit(sl())..getAllProducts()..getAllOrders()..getAnalytics());
  sl.registerFactory(() => HomeCubit(sl())..getDealOfTheDay());
  sl.registerFactory(() => CartCubit(sl())..getCart());
  sl.registerFactory(() => AccountCubit(sl())..getUserOrders());

  /// repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl()),
  );
 sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl()),
  );
sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(sl()),
  );

  /// core
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl(sl()));

  /// EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
