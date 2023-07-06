import '../../exports.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.itemCount,
    required this.image,
    this.height,
    this.autoPlay = true,
  });
  final String image;
  final double? height;
  final int itemCount;
  final bool autoPlay;

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
        itemCount: itemCount,
        itemBuilder: (_, itemIndex, __) => Image.memory(
          base64Decode(image),
          fit: BoxFit.fill,
        ),
        options: CarouselOptions(
          autoPlay: autoPlay,
          viewportFraction: 1,
          height: height,
        ),
      );
}
