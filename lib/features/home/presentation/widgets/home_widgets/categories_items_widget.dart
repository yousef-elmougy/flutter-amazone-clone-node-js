import '../../../../../exports.dart';

class CategoriesItemsWidget extends StatefulWidget {
  const CategoriesItemsWidget({super.key, required this.category});

  final String category;

  @override
  State<CategoriesItemsWidget> createState() => _CategoriesItemsWidgetState();
}

class _CategoriesItemsWidgetState extends State<CategoriesItemsWidget> {
  @override
  void initState() {
    super.initState();
    getProductsByCategory();
  }

  Future<void> getProductsByCategory() async =>
      await context.read<HomeCubit>().getProductsByCategory(widget.category);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.category, style: Style.textBold_14),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: kAppBarGradient),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetProductsByCategoryLoading) {
              return const LoaderWidget();
            } else {
              final products = context.read<HomeCubit>().products;
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
                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouter.productDetails,
                      arguments: product,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Image.memory(
                                base64Decode(product.images[0]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
}
