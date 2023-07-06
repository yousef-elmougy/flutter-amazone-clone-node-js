import '../../../../../exports.dart';

class ProductsControlWidget extends StatelessWidget {
  const ProductsControlWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          if (state is GetAllProductsLoading) {
            return const LoaderWidget();
          } else {
            final products = context.read<AdminCubit>().products;
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(4),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .98,
                crossAxisSpacing: 4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: Image.network(
                            product.images[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () async => await context
                                .read<AdminCubit>()
                                .deleteProduct(product.id!),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      );
}
