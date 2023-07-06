import '../../../../../exports.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 110,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          itemCount: categoryImages.length,
          separatorBuilder: (context, index) => const SizedBox(width: 30),
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              AppRouter.categories,
              arguments: categoryImages[index]['title'],
            ),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    categoryImages[index]['image']!,
                    height: 60,
                  ),
                ),
                Text(categoryImages[index]['title']!),
              ],
            ),
          ),
        ),
      );
}
