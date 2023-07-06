import 'package:amazon_clone/features/account/presentation/screens/order_details_screen.dart';

import '../../exports.dart';
import '../../features/cart/presentation/screens/address_screen.dart';

class AppRouter {
  static const addProduct = '/add-product';
  static const categories = '/categories';
  static const search = '/search';
  static const productDetails = '/product-details';
  static const dealOfTheDay = '/deal-of-the-day';
  static const address = '/address';
  static const orderDetails = '/order-details';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case addProduct:
        return CustomPageRoute(
          const AddProductScreen(),
          Transitions.rightToLeft,
        );

      case categories:
        final category = settings.arguments as String;
        return CustomPageRoute(
          CategoriesItemsWidget(category: category),
          Transitions.rightToLeft,
        );

      case search:
        final result = settings.arguments as String;
        return CustomPageRoute(
          SearchScreen(result: result),
          Transitions.rightToLeft,
        );
      case productDetails:
        final product = settings.arguments as Product;
        return CustomPageRoute(
          ProductDetailsScreen(product: product),
          Transitions.rightToLeft,
        );
      case dealOfTheDay:
        return CustomPageRoute(
          const DealOfTheDayScreen(),
          Transitions.rightToLeft,
        );
      case address:
        final cart = settings.arguments as Cart;
        return CustomPageRoute(
          AddressScreen(cart: cart),
          Transitions.rightToLeft,
        );
      case orderDetails:
        final order = settings.arguments as Orders;
        return CustomPageRoute(
          OrderDetailsScreen(order: order),
          Transitions.rightToLeft,
        );

      default:
        return _defaultRoute();
    }
  }

  static MaterialPageRoute<dynamic> _defaultRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('ERROR : Route Not Found')),
          body: const Center(
            child: Text(
              'ERROR : Route Not Found',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final user = context.read<UserCubit>().user;
          if (state is GetUserLoading) {
            return const Scaffold(body: LoaderWidget());
          }
          if (user.token.isEmpty) {
            return const AuthScreen();
          } else {
            if (user.type == 'user') {
              return const LayoutScreen();
            } else {
              return const AdminLayoutScreen();
            }
          }
        },
      );
}
