import '../../../../library.dart';

class QmIconButton extends StatelessWidget {
  const QmIconButton({super.key, required this.icon, this.onPressed});
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {},
      iconSize: 20,
      icon: Icon(
        icon,
        color: ColorConstants.secondaryColor,
      ),
    );
  }
}
