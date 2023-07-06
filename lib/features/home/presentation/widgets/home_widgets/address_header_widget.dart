
import '../../../../../exports.dart';

class AddressHeaderWidget extends StatelessWidget {
  const AddressHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          Text('Deliver to Egypt'),
        ],
      ),
    );
  }
}
