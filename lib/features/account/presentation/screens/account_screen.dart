import '../../../../exports.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                amazonLogo,
                width: 130,
                height: 50,
                alignment: Alignment.bottomCenter,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: kAppBarGradient),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DynamicTextHighlightingWidget(
                      text: 'Hello, Admin',
                      highlights: ['Admin'],
                      style: Style.textNormal_24,
                      highlightStyle: Style.textBold_24,
                    ),
                    const SizedBox(height: 20),
                    const TopButtonsWidget(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Your Orders',
                          style: Style.textBold_20,
                        ),
                        //! SEE ALL ORDERS
                        TextButton(
                          onPressed: null,
                          child: Text(
                            '',
                            style: Style.textNormal_18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  if (state is GetUserOrdersLoading) {
                    return const SliverToBoxAdapter(child: LoaderWidget());
                  }
                  final orders = context.read<AccountCubit>().orders;
                  return orders.isEmpty
                      ? const SliverToBoxAdapter(child: EmptyWidget(text: "",))
                      : SliverGrid.builder(
                          itemCount: orders.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 3.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouter.orderDetails,
                              arguments: orders[index],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kGreyBackgroundCOlor),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    orders[index]
                                        .cartItems[0]
                                        .product
                                        .images[0],
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      );
}
