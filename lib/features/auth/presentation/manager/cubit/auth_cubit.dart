import '../../../../../exports.dart';

part 'auth_state.dart';

enum Auth { register, login }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthInitial());

  final AuthRepository authRepository;

  Auth auth = Auth.register;

  void authToggle(Auth? value) {
    auth = value!;
    emit(AuthToggle());
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    final register = await authRepository.register(
      name: name,
      email: email,
      password: password,
    );
    register.fold((error) => emit(RegisterError(error.message)),
        (_) => emit(const RegisterSuccess()));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());
    final login = await authRepository.login(
      email: email,
      password: password,
    );
    login.fold((error) => emit(LoginError(error.message)),
        (response) => emit(LoginSuccess(response)));
  }


}
