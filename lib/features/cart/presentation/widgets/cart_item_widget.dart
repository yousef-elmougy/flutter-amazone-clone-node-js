import '../../../../exports.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;
  @override
  Widget build(BuildContext context) => BlocListener<CartCubit, CartState>(
        listener: _listenToAddOrRemoveCartItem,
        child: Column(
          children: [
            ProductItemWidget(
              product: cartItem.product,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async =>
                          await context.read<CartCubit>().deleteCartItem(
                                cartItem.product.id!,
                              ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async =>
                          await context.read<CartCubit>().removeCartItem(
                                cartItem.product.id!,
                              ),
                      icon: Container(
                        height: 35,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    ),
                  ),
                  Text(
                    '${cartItem.quantity}',
                    style: Style.textBold_24,
                  ),
                  Expanded(
                    child: IconButton(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async =>
                          await context.read<CartCubit>().addCartItem(
                                cartItem.product.id!,
                              ),
                      icon: Container(
                        height: 35,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Future<void> _listenToAddOrRemoveCartItem(context, state) async {
    if (state is AddCartLoading ||
        state is RemoveCartLoading ||
        state is DeleteCartLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is AddCartError ||
        state is RemoveCartError ||
        state is DeleteCartError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is AddCartSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Item Added Successfully', color: Colors.green);
    } else if (state is RemoveCartSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Item Removed Successfully');
    } else if (state is DeleteCartSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Item Deleted Successfully');
    }
  }
}
