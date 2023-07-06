import '../../exports.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({
    super.key,
    required this.screens,
    required this.isAdmin,
  });

  final List<Widget> screens;
  final bool isAdmin;

  @override
  State<BottomBarWidget> createState() => _BottomStateBarWidget();
}

class _BottomStateBarWidget extends State<BottomBarWidget>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: currentIndex, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.only(top: 10),
          child: TabBar(
            controller: tabController,
            onTap: (index) => setState(() => currentIndex = index),
            isScrollable: false,
            indicator: const UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(30, 0.0, 30, 53),
              borderSide: BorderSide(color: kPrimaryColor, width: 4),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => states.contains(MaterialState.focused)
                  ? null
                  : Colors.transparent,
            ),
            tabs: [
              Tab(
                icon: _tabBarIcon(Icons.home_outlined, 0),
              ),
              Tab(
                icon: _tabBarIcon(
                  widget.isAdmin
                      ? Icons.analytics_outlined
                      : Icons.person_2_outlined,
                  1,
                ),
              ),
              Tab(
                icon: widget.isAdmin
                    ? _tabBarIcon(Icons.all_inbox_outlined, 2)
                    : BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          final cartItems =
                              context.watch<CartCubit>().cart?.cartItems;
                          return Badge.count(
                            alignment: const AlignmentDirectional(10, -4),
                            count: cartItems?.length ??0,
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            textColor: currentIndex == 2
                                ? kPrimaryColor
                                : Colors.black87,
                            padding: const EdgeInsets.all(1),
                            backgroundColor: Colors.white,
                            child: _tabBarIcon(Icons.add_shopping_cart, 2),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        body: widget.screens[currentIndex],
      );

  Widget _tabBarIcon(IconData icon, int index) => Icon(
        icon,
        size: 30,
        color: currentIndex == index ? kPrimaryColor : Colors.black87,
      );
}
