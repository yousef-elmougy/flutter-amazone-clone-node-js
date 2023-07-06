import '../../../../exports.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this.accountRepository) : super(const AccountInitial());
  final AccountRepository accountRepository;
  List<Orders> orders = [];

  Future<void> getUserOrders() async {
    emit(const GetUserOrdersLoading());
    final orders = await accountRepository.getUserOrders();
    orders.fold((error) => emit(GetUserOrdersError(error.message)), (orders) {
      this.orders = orders;
      emit(GetUserOrdersSuccess());
    });
  }

  Future<void> changeOrderStatus({
    required String orderId,
    required int status,
  }) async {
    emit(const ChangeOrderStatusLoading());
    final orders = await accountRepository.changeOrderStatus(
      orderId: orderId,
      status: status,
    );
    orders.fold((error) => emit(ChangeOrderStatusError(error.message)),
        (_) => emit(const ChangeOrderStatusSuccess()));
  }
}
