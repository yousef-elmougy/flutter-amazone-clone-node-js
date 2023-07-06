import '../../../../exports.dart';

class DealOfTheDayScreen extends StatelessWidget {
  const DealOfTheDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSearchWidget(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is DealOfTheDayLoading) {
            return const LoaderWidget();
          } else {
            final products = context.read<HomeCubit>().dealOfTheDayProducts;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRouter.productDetails,
                  arguments: products[index],
                ),
                child: DealOfTheDayItemWidget(product: products[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
