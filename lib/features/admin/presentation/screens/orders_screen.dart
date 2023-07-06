import '../../../../exports.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Orders', style: Style.textBold_14),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: kAppBarGradient),
          ),
        ),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is GetAllOrdersLoading) {
              return const LoaderWidget();
            }
            final orders = context.read<AdminCubit>().orders;
            return orders.isEmpty
                ? const LoaderWidget()
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(4),
                    itemCount: orders.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .98,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRouter.orderDetails,
                        arguments: orders[index],
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Image.network(
                              orders[index].cartItems[0].product.images[0],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      );
}
