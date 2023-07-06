import '../../../../exports.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? name, password, email;

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listener: _listenToRegister,
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RadioListTile<Auth>(
                value: Auth.register,
                groupValue: cubit.auth,
                onChanged: cubit.authToggle,
                title: const Text(
                  'Create Account',
                  style: Style.textBold_14,
                ),
              ),
              if (cubit.auth == Auth.register)
                Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormFieldWidget(
                        hintText: 'Name',
                        onSaved: (value) => setState(() => name = value),
                      ),
                      TextFormFieldWidget(
                        hintText: 'Email',
                        onSaved: (value) => setState(() => email = value),
                      ),
                      TextFormFieldWidget(
                        hintText: 'Password',
                        onSaved: (value) => setState(() => password = value),
                      ),
                      ButtonWidget(
                        onPressed: _register,
                        title: 'Sign Up',
                      ),
                    ].addSpaceBetween(const SizedBox(height: 10)),
                  ),
                ),
            ],
          );
        },
      );

  Future<void> _listenToRegister(context, state) async {
    if (state is RegisterLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is RegisterError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is RegisterSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Account Created Successfully', color: Colors.green);
    }
  }

  Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<AuthCubit>().register(
            name: name!,
            email: email!,
            password: password!,
          );
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
