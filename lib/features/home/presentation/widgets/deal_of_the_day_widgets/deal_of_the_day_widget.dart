import '../../../../../exports.dart';

class DealOfTheDayWidget extends StatelessWidget {
  const DealOfTheDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Deal of the day', style: Style.textBold_20),
            const SizedBox(height: 10),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is DealOfTheDayLoading) {
                  return const SizedBox(height: 200, child: LoaderWidget());
                } else {
                  final product =
                      context.read<HomeCubit>().dealOfTheDayProducts.first;
                  return DealOfTheDayItemWidget(product: product);
                }
              },
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.dealOfTheDay),
              child: const Text(
                'see all Deals',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
            ),
          ],
        ),
      );
}
