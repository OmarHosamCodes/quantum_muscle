import 'package:quantum_muscle/library.dart';

class ChooseState {
  ChooseState({
    required this.exerciseContent,
    required this.workoutContent,
    required this.profileImage,
    required this.addImage,
  });
  String? exerciseContent;
  String? workoutContent;
  String? profileImage;
  String? addImage;

  ChooseState copyWith({
    String? exerciseContent,
    String? workoutContent,
    String? profileImage,
    String? addImage,
  }) {
    return ChooseState(
      exerciseContent: exerciseContent ?? this.exerciseContent,
      workoutContent: workoutContent ?? this.workoutContent,
      profileImage: profileImage ?? this.profileImage,
      addImage: addImage ?? this.addImage,
    );
  }
}

class ChooseStateNotifier extends StateNotifier<ChooseState> {
  ChooseStateNotifier()
      : super(
          ChooseState(
            exerciseContent: null,
            workoutContent: null,
            profileImage: null,
            addImage: null,
          ),
        );

  void setExerciseContent(String content) {
    state = state.copyWith(exerciseContent: content);
  }

  void setWorkoutContent(String content) {
    state = state.copyWith(workoutContent: content);
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
