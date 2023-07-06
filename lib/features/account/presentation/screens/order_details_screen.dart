import '../../../../exports.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final Orders order;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final List<Step> steps = [
      Step(
        title: const Text('Pending'),
        content: const Text('Your Order is yet to be Delivered'),
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: _currentStep > 0,
      ),
      Step(
        title: const Text('Completed'),
        content:
            const Text('Your Order Has Been Delivered, you are yet to sign'),
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: _currentStep > 1,
      ),
      Step(
        title: const Text('Received'),
        content: const Text('Your Order Has Been Delivered and signed by you.'),
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: _currentStep > 2,
      ),
      Step(
        title: const Text('Delivered'),
        content: const Text('Your Order Has Been Delivered !'),
        state: _currentStep >= 3 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 3,
      ),
    ];
    return Scaffold(
      appBar: const AppBarSearchWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Text("View Order Details", style: Style.textBold_20),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Order Date:   ${widget.order.orderAt}'),
                  Text('Order ID:       ${widget.order.id}'),
                  Text('Order Total:  \$${widget.order.totalOrderPrice}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Purchase Details", style: Style.textBold_20),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.order.cartItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(border: Border.all()),
                child: ProductItemWidget(
                  product: widget.order.cartItems[index].product,
                  isOrder: true,
                  quantity: widget.order.cartItems[index].quantity,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Tracking", style: Style.textBold_20),
            const SizedBox(height: 10),
            Stepper(
              physics: const NeverScrollableScrollPhysics(),
              currentStep: _currentStep,
              steps: steps,
              controlsBuilder: (context, details) {
                if (context.read<UserCubit>().user.type == "admin" &&
                    _currentStep < steps.length-1) {
                  return ButtonWidget(
                    onPressed: () {
                      context.read<AccountCubit>().changeOrderStatus(
                            orderId: widget.order.id,
                            status: _currentStep + 1,
                          );
                      _currentStep++;
                      setState(() {});
                    },
                    title: 'Done',
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
