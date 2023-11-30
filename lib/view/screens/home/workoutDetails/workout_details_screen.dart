import '../../../../library.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({super.key, required this.workoutId});
  final String workoutId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QmText(
        text: 'Workout Details Screen For $workoutId',
      ),
    );
  }
}
