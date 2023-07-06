import '../../../../exports.dart';

class TopButtonsWidget extends StatefulWidget {
  const TopButtonsWidget({super.key});

  @override
  State<TopButtonsWidget> createState() => _TopButtonsWidgetState();
}

class _TopButtonsWidgetState extends State<TopButtonsWidget> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: Ink(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: kGreyBackgroundCOlor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Text('Your Orders', textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () async {
                final user = context.read<UserCubit>().user;
                context.read<UserCubit>().setUser(user.copyWith(token: ""));
                await sl<SharedPreferences>().setString(cacheToken, "");
              },
              child: Ink(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: kGreyBackgroundCOlor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Text('Logout', textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      );
}
