
import '../../../../exports.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Product', style: Style.textBold_14),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: kAppBarGradient),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: const [
            AddProductImageWidget(),
            SizedBox(height: 20),
            AddProductFormWidget(),
          ],
        ),
      );
}
