import '../../../../exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppBarSearchWidget(),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            AddressHeaderWidget(),
            CategoriesWidget(),
            BannerWidget(),
            DealOfTheDayWidget(),
          ],
        ),
      );
}
