
import '../../../../exports.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  SizedBox(height: 30),
                  Text(
                    'Welcome',
                    style: Style.textBold_20,
                  ),
                  RegisterFormWidget(),
                  LoginFormWidget(),
                ],
              ),
            ),
          ),
        ),
      );
}
