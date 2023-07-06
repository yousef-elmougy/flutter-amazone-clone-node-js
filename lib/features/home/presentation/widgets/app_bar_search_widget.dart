import '../../../../exports.dart';

class AppBarSearchWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarSearchWidget({
    super.key,
    this.onFieldSubmitted,
    this.isSearch = true,
  });
  final void Function(String)? onFieldSubmitted;
  final bool isSearch;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearch
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextFormFieldWidget(
                border: InputBorder.none,
                textInputAction: TextInputAction.done,
                fillColor: Colors.white,
                filled: true,
                suffixIcon: const Icon(Icons.mic),
                prefixIcon: const Icon(Icons.search),
                hintText: 'search amazon',
                onFieldSubmitted: onFieldSubmitted ??
                    (result) => Navigator.pushNamed(
                          context,
                          AppRouter.search,
                          arguments: result,
                        ),
              ),
            )
          : const SizedBox.shrink(),
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: kAppBarGradient),
      ),
    );
  }
}
