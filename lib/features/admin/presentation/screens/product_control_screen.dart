import '../../../../exports.dart';

class ProductControlScreen extends StatelessWidget {
  const ProductControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => Navigator.pushNamed(context, AppRouter.addProduct),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            Image.asset(
              amazonLogo,
              width: 130,
              height: 50,
              alignment: Alignment.bottomCenter,
            ),
            const Text('Admin', style: Style.textBold_20),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kAppBarGradient),
        ),
      ),
      body: const ProductsControlWidget(),
    );
  }
}
