
import 'package:file_picker/file_picker.dart';

import '../../exports.dart';

/* Future<List<Uint8List>> pickImage() async {
  List<Uint8List> images = [];
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true,
  );

  if (result != null) {
    final files = result.files.map((e) => File(e.path!)).toList();

    for (var i = 0; i < files.length; i++) {
      final image = await files[i].readAsBytes();
      images.add(image);
    }
  }

  debugPrint("$images");
  return images;
} */

Future<List<String>> pickImages() async {
  List<String> images = [];
  try {
    final files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        // final bytes = File(files.files[i].path!).readAsBytesSync();
        // final image64 = base64Encode(bytes);
        final image = files.files[i].path;
        if (image != null) {
          images.add(image);
        }
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
