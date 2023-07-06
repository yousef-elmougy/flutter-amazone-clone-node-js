

import '../../exports.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const screens = [HomeScreen(), AccountScreen(), CartScreen()];
    return const BottomBarWidget(screens: screens, isAdmin: false);
  }
}
