import 'package:quantum_muscle/library.dart';

class ChooseState {
  ChooseState({
    required this.exerciseImage,
    required this.publicExerciseImage,
    required this.workoutImage,
    required this.publicWorkoutImage,
    required this.profileImage,
    required this.addImage,
  });
  final String exerciseImage;
  final String publicExerciseImage;
  final String workoutImage;
  final String publicWorkoutImage;
  final String profileImage;
  final String addImage;

  ChooseState copyWith({
    String? exerciseImage,
    String? publicExerciseImage,
    String? workoutImage,
    String? publicWorkoutImage,
    String? profileImage,
    String? addImage,
  }) {
    return ChooseState(
      exerciseImage: exerciseImage ?? this.exerciseImage,
      publicExerciseImage: publicExerciseImage ?? this.publicExerciseImage,
      workoutImage: workoutImage ?? this.workoutImage,
      publicWorkoutImage: publicWorkoutImage ?? this.publicWorkoutImage,
      profileImage: profileImage ?? this.profileImage,
      addImage: addImage ?? this.addImage,
    );
  }
}

class ChooseStateNotifier extends StateNotifier<ChooseState> {
  ChooseStateNotifier()
      : super(
          ChooseState(
            exerciseImage: SimpleConstants.emptyString,
            publicExerciseImage: SimpleConstants.emptyString,
            workoutImage: SimpleConstants.emptyString,
            publicWorkoutImage: SimpleConstants.emptyString,
            profileImage: SimpleConstants.emptyString,
            addImage: SimpleConstants.emptyString,
          ),
        );

  void setExerciseImage(String image) {
    state = state.copyWith(exerciseImage: image);
  }

  void setPublicExerciseImage(String image) {
    state = state.copyWith(publicExerciseImage: image);
  }

  void setWorkoutImage(String image) {
    state = state.copyWith(workoutImage: image);
  }

  void setPublicWorkoutImage(String image) {
    state = state.copyWith(publicWorkoutImage: image);
  }

  void setProfileImage(String image) {
    state = state.copyWith(profileImage: image);
  }

  void setAddImage(String image) {
    state = state.copyWith(addImage: image);
  }
}

final chooseProvider = StateNotifierProvider<ChooseStateNotifier, ChooseState>(
  (ref) => ChooseStateNotifier(),
);
