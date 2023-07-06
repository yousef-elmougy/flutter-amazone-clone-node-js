import '../../../../exports.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future<void> getProduct() async =>
      await context.read<HomeCubit>().getProduct(widget.product.id!);

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppBarSearchWidget(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetProductLoading) {
              return const LoaderWidget();
            } else {
              final product = context.read<HomeCubit>().product;
              return ListView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.id!, style: Style.textNormal_16),
                      RatingBarWidget(rating: product.averageRating, size: 15),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider.builder(
                    itemCount: product.images.length,
                    itemBuilder: (_, itemIndex, __) => Image.network(
                      product.images[itemIndex],
                      fit: BoxFit.fill,
                    ),
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DynamicTextHighlightingWidget(
                    text: 'Total 1500',
                    highlights: ['1500'],
                    style: Style.textBold_20,
                    highlightStyle:
                        TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(product.description),
                  const SizedBox(height: 20),
                  ButtonWidget(onPressed: () {}, title: 'Buy Now'),
                  const SizedBox(height: 20),
                  AddToCardButtonWidget(product: product),
                  const SizedBox(height: 20),
                  const Text('Rate The Product', style: Style.textBold_24),
                  AddRatingWidget(product: widget.product)
                ],
              );
            }
          },
        ),
      );
}
