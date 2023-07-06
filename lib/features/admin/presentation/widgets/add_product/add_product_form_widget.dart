import '../../../../../exports.dart';

class AddProductFormWidget extends StatefulWidget {
  const AddProductFormWidget({super.key});

  @override
  State<AddProductFormWidget> createState() => _AddProductFormWidgetState();
}

class _AddProductFormWidgetState extends State<AddProductFormWidget> {
  String? name, description, price, quantity;
  String category = 'Mobiles';
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    const categoriesTitles = [
      'Mobiles',
      'Electronics',
      'Essentials',
      'Appliances',
      'Books',
      'Fashion',
    ];

    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          TextFormFieldWidget(
            hintText: 'Name',
            onSaved: (value) => setState(() => name = value),
          ),
          TextFormFieldWidget(
            hintText: 'Description',
            maxLine: 5,
            onSaved: (value) => setState(() => description = value),
          ),
          TextFormFieldWidget(
            hintText: 'Price',
            onSaved: (value) => setState(() => price = value),
            keyboardType: TextInputType.number,
          ),
          TextFormFieldWidget(
            hintText: 'Quantity',
            onSaved: (value) => setState(() => quantity = value),
            keyboardType: TextInputType.number,
          ),
          DropDownWidget<String>(
            value: category,
            onChanged: (value) => setState(() => category = value!),
            items: categoriesTitles,
          ),
          BlocListener<AdminCubit, AdminState>(
            listener: _listenToAddProduct,
            child: ButtonWidget(
              onPressed: _addProduct,
              title: 'Add',
            ),
          ),
        ].addSpaceBetween(const SizedBox(height: 15)),
      ),
    );
  }

  Future<void> _listenToAddProduct(context, state) async {
    if (state is AddProductLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is AddProductError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is AddProductSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Product Added Successfully', color: Colors.green);
      Navigator.canPop(context) ? Navigator.pop(context) : null;
    }
  }

  Future<void> _addProduct() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<AdminCubit>().addProduct(
            name: name!,
            description: description!,
            category: category,
            price: double.parse(price!),
            quantity: double.parse(quantity!),
          );
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
