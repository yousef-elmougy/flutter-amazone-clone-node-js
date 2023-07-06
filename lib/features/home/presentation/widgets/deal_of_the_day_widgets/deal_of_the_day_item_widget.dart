
import '../../../../../exports.dart';

class DealOfTheDayItemWidget extends StatelessWidget {
  const DealOfTheDayItemWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10),
            ),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                product.images[0],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: Style.textMedium_16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('\$${product.price}',
                    style: Style.textBold_20),
              ],
            ),
          ),
        ],
      ),
    );
}
