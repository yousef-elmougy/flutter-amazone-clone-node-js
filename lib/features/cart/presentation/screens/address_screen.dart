import 'package:pay/pay.dart';

import '../../../../exports.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.cart});
  final Cart cart;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String? house, street, pinCode, city;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserCubit>().user.address;
    final paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '${widget.cart.subtotal}',
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      appBar: const AppBarSearchWidget(isSearch: false),
      body: BlocListener<CartCubit, CartState>(
        listener: _listenToOrder,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                if (address.isNotEmpty) Text('Address:  $address'),
                if (context.watch<UserCubit>().user.address.isNotEmpty)
                  const Text('OR'),
                TextFormFieldWidget(
                  hintText: 'Building , House n.',
                  onSaved: (house) => setState(() => this.house = house),
                ),
                TextFormFieldWidget(
                  hintText: 'Area , Street',
                  onSaved: (street) => setState(() => this.street = street),
                ),
                TextFormFieldWidget(
                  hintText: 'Pin Code',
                  keyboardType: TextInputType.number,
                  onSaved: (pinCode) => setState(() => this.pinCode = pinCode),
                ),
                TextFormFieldWidget(
                  hintText: 'Town/City',
                  textInputAction: TextInputAction.done,
                  onSaved: (city) => setState(() => this.city = city),
                ),
                ApplePayButton(
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(kApplePayConfig),
                  paymentItems: paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: _onApplePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onPressed: _setOrder,
                  width: double.infinity,
                ),
                GooglePayButton(
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(kGooglePayConfig),
                  paymentItems: paymentItems,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: _onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onPressed: _setOrder,
                  width: double.infinity,
                ),
              ].addSpaceBetween(const SizedBox(height: 16)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setOrder() async {
    final address = context.read<UserCubit>().user.address;
    
    if (house != null || street != null || pinCode != null || city != null) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final newAddress = "$house , $street , $pinCode , $city";
        await context.read<UserCubit>().addAddress(newAddress);
        await context.read<CartCubit>().createOrder(
              cartId: widget.cart.id,
              address: newAddress,
            );
      } else {
        setState(() => autovalidateMode = AutovalidateMode.always);
      }
    } else if (address.isNotEmpty) {
      
        await context.read<CartCubit>().createOrder(
              cartId: widget.cart.id,
              address: address,
            );
      } else {
        hideToast();
        showToast('Add Address');
      }
    }
  

  void _onApplePayResult(paymentResult) {}

  void _onGooglePayResult(paymentResult) {}

  Future<void> _listenToOrder(context, state) async {
    if (state is CreateOrderLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is CreateOrderError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is CreateOrderSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Order Created Successfully', color: Colors.green);
    }
  }
}
