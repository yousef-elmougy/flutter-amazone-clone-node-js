

import '../../../../../exports.dart';

class AddRatingWidget extends StatelessWidget {
  const AddRatingWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) => BlocListener<HomeCubit, HomeState>(
        listener: _listenToAddRating,
        child: RatingBarWidget(
          rating: userRating(context),
          onRatingUpdate: (rating) async => await context
              .read<HomeCubit>()
              .addRating(productId: product.id!, rating: rating),
        ),
      );

  Future<void> _listenToAddRating(context, state) async {
    if (state is AddRatingLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is AddRatingError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      return showToast(state.error);
    }
    if (state is AddRatingSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
    }
  }

  double userRating(BuildContext context) {
    final ratings = context.read<HomeCubit>().product.ratings;
    final currentUserId = context.read<UserCubit>().user.id;
    return ratings.isEmpty
        ? 0
        : ratings.firstWhere((rating) => rating.userId == currentUserId).rating;
  }
}
