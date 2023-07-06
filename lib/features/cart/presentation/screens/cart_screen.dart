
import '../../../../exports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSearchWidget(),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is GetCartLoading) {
            return const LoaderWidget();
          }
          final cart = context.read<CartCubit>().cart;
          final cartItems = context.read<CartCubit>().cart?.cartItems;
          return cart == null || cartItems == null
              ? const EmptyWidget(
                  text: 'Add Some Products',
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 200,
                  ),
                )
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DynamicTextHighlightingWidget(
                    text: 'Subtotal \$${cart.subtotal}',
                    highlights: ['\$${cart.subtotal}'],
                    style: Style.textNormal_20,
                    highlightStyle: Style.textBold_24,
                  ),
                  const SizedBox(height: 10),
                  ButtonWidget(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRouter.address,
                      arguments: cart,
                    ),
                    title:
                        'Proceed to Buy (${cartItems.length == 1 ? '${cartItems.length} item' : '${cartItems.length} items'})',
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.black),
                    itemBuilder: (context, index) =>
                        CartItemWidget(cartItem: cartItems[index]),
                  ),
                ],
              );
        },
      ),
    );
  }


}

