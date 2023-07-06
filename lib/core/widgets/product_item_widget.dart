import '../../exports.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    this.isOrder = false,
    this.quantity = 0,
  });
  final bool isOrder;
  final int quantity;
  final Product product;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRouter.productDetails,
          arguments: product,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 150,
              child: AspectRatio(
                aspectRatio: .7,
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Style.textMedium_16,
                  ),
                ),
                const SizedBox(height: 10),
                RatingBarWidget(
                  rating: product.averageRating,
                  size: 15.0,
                ),
                const SizedBox(height: 10),
                Text(
                  '\$ ${product.price}',
                  style: Style.textBold_20,
                ),
                const SizedBox(height: 5),
                if (!isOrder) const Text('Eligible for FREE Shipping'),
                const SizedBox(height: 5),
                if (isOrder) Text('Quantity: $quantity'),
                if (!isOrder)
                  const Text(
                    'In Stoke',
                    style: TextStyle(color: Colors.teal),
                  ),
              ],
            ),
          ],
        ),
      );
}
