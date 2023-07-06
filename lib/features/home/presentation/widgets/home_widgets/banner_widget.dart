import '../../../../../exports.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
        itemCount: carouselImages.length,
        itemBuilder: (_, itemIndex, __) =>
            Image.network(carouselImages[itemIndex], fit: BoxFit.fill),
        options: CarouselOptions(autoPlay: true, viewportFraction: 1),
      );
}
