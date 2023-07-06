import '../../../../exports.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepository) : super(const CartInitial());

  final CartRepository cartRepository;
  Cart? cart;
  Future<void> addCartItem(String productId) async {
    emit(const AddCartLoading());
    final cart = await cartRepository.addCartItem(productId);
    cart.fold((error) => emit(AddCartError(error.message)), (_) {
      getCart();
      emit(const AddCartSuccess());
    });
  }

  Future<void> removeCartItem(String productId) async {
    emit(const RemoveCartLoading());
    final cart = await cartRepository.removeCartItem(productId);
    cart.fold((error) => emit(RemoveCartError(error.message)), (_) {
      getCart();
      emit(const RemoveCartSuccess());
    });
  }

  Future<void> deleteCartItem(String productId) async {
    emit(const DeleteCartLoading());
    final cart = await cartRepository.deleteCartItem(productId);
    cart.fold((error) => emit(DeleteCartError(error.message)), (_) {
      getCart();
      emit(const DeleteCartSuccess());
    });
  }

  Future<void> getCart() async {
    emit(const GetCartLoading());
    final cart = await cartRepository.getCart();
    cart.fold((error) => emit(GetCartError(error.message)), (cart) {
      this.cart = cart;
      emit( GetCartSuccess());
    });
  }

  Future<void> createOrder({
    required String cartId,
    required String address,
  }) async {
    emit(const CreateOrderLoading());
    final order =
        await cartRepository.createOrder(cartId: cartId, address: address);
    order.fold((error) => emit(CreateOrderError(error.message)), (_) {
      getCart();
      emit(const CreateOrderSuccess());
    });
  }
}
