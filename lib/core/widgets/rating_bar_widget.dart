import '../../exports.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    this.rating = 0,
    this.size = 40,
    this.onRatingUpdate,
  });

  final double rating;
  final double size;
  final void Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) => RatingBar.builder(
        initialRating: rating,
        glow: false,
        itemSize: size,
        allowHalfRating: true,
        ignoreGestures: onRatingUpdate == null,
        itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
        onRatingUpdate: (rating) => onRatingUpdate!(rating),
      );
}
