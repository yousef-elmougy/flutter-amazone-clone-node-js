import '../../../../exports.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? password, email;

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listener: _listenToLogin,
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RadioListTile<Auth>(
                value: Auth.login,
                groupValue: cubit.auth,
                onChanged: cubit.authToggle,
                title: const Text(
                  'Sign-in',
                  style: Style.textBold_14,
                ),
              ),
              if (cubit.auth == Auth.login)
                Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormFieldWidget(
                        hintText: 'Email',
                        onSaved: (value) => setState(() => email = value),
                      ),
                      TextFormFieldWidget(
                        hintText: 'Password',
                        onSaved: (value) => setState(() => password = value),
                      ),
                      ButtonWidget(
                        onPressed: _login,
                        title: 'Sign in',
                      ),
                    ].addSpaceBetween(const SizedBox(height: 10)),
                  ),
                ),
            ],
          );
        },
      );

  Future<void> _listenToLogin(context, state) async {
    if (state is LoginLoading) {
      // Navigator.canPop(context) ? Navigator.pop(context) : null;
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is LoginError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is LoginSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      final response = state.response;

      final user = User.fromJson(response);

      BlocProvider.of<UserCubit>(context).setUser(user);

      await sl<SharedPreferences>().setString(cacheToken, response['token']);
      hideToast();
      showToast('Login Successfully', color: Colors.green);
    }
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<AuthCubit>().login(
            email: email!,
            password: password!,
          );
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
