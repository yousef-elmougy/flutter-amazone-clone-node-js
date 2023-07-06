import '../../../exports.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitial());
  final UserRepository userRepository;

  User user = const User(
    address: '',
    email: '',
    id: '',
    name: '',
    password: '',
    token: '',
    type: '',
  );

  void setUser(User user) {
    this.user = user;
    debugPrint("USER ================================== >>> $user");
    emit(SetUser());
  }

  Future<void> getUser() async {
    emit(GetUserLoading());
    final user = await userRepository.getUser();
    user.fold((error) => emit(GetUserError(error.message)), (user) {
      setUser(user);
      emit(GetUserSuccess(user));
    });
  }
  
  Future<void> addAddress(String address) async {
    emit(AddAddressLoading());
    final user = await userRepository.addAddress(address);
    user.fold((error) => emit(AddAddressError(error.message)), (address) {
      setUser(address);
      emit(AddAddressSuccess(address));
    });
  }
}
