import 'dart:io';

import '../../../../../exports.dart';

class AddProductImageWidget extends StatelessWidget {
  const AddProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          if (state is SelectProductImagesLoading) {
            return const SizedBox(height: 150, child: LoaderWidget());
          } else {
            final images = context.read<AdminCubit>().images;
            return images.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (_, itemIndex, __) => Image.file(
                      File(images[itemIndex]),// base64Decode(images[itemIndex]),
                      fit: BoxFit.fill,
                    ),
                    options: CarouselOptions(viewportFraction: 1),
                  )
                : InkWell(
                    onTap: context.read<AdminCubit>().selectProductImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: const [10, 5],
                      radius: const Radius.circular(12),
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Icon(Icons.folder_outlined, size: 40),
                            Text(
                              'Select Product Image',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }
        },
      );
}
