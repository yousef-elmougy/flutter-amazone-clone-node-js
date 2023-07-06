
import '../../../../exports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.result});

  final String result;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    search();
  }

  Future<void> search() async =>
      await context.read<HomeCubit>().search(widget.result);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarSearchWidget(
          onFieldSubmitted: (result) async =>
              await context.read<HomeCubit>().search(result),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const LoaderWidget();
            } else {
              final productsSearch = context.read<HomeCubit>().productsSearch;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemCount: productsSearch.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    ProductItemWidget(product: productsSearch[index]),
              );
            }
          },
        ),
      );
}
