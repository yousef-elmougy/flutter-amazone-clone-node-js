import '../../../../../exports.dart';

class AddToCardButtonWidget extends StatelessWidget {
  const AddToCardButtonWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: _listenToAddToCart,
      child: ButtonWidget(
        onPressed: () async =>
            await context.read<CartCubit>().addCartItem(product.id!),
        title: 'Add to Cart',
        color: const Color.fromRGBO(240, 204, 59, 1),
      ),
    );
  }

  Future<void> _listenToAddToCart(context, state) async {
    if (state is AddCartLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is AddCartError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      return showToast(state.error);
    }
    if (state is AddCartSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      showToast('Product Added Successfully', color: Colors.green);
    }
  }
}
