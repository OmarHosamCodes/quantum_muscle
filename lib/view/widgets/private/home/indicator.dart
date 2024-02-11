import 'package:quantum_muscle/library.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    required this.color, required this.text, required this.isSquare, super.key,
  });

  final Color color;
  final String text;
  final bool isSquare;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        QmText(
          text: text,
        ),
      ],
    );
  }
}
