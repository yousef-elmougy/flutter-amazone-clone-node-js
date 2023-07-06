import '../../../../../exports.dart';

class AdminLayoutScreen extends StatelessWidget {
  const AdminLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const screens = [
      ProductControlScreen(),
      AnalyticsScreen(),
      OrdersScreen(),
    ];
    return const BottomBarWidget(screens: screens, isAdmin: true);
  }
}
