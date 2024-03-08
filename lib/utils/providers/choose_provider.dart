import 'package:quantum_muscle/library.dart';

/// Represents the state of the Choose feature.
class ChooseState {
  /// Constructs a new instance of [ChooseState].
  ChooseState({
    required this.exerciseContent,
    required this.workoutContent,
    required this.profileImage,
    required this.addImage,
  });

  /// The exercise content.
  String? exerciseContent;

  /// The workout content.
  String? workoutContent;

  /// The profile image.
  String? profileImage;

  /// The additional image.
  String? addImage;

  /// Creates a copy of the current [ChooseState] instance with the provided values.
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

/// Notifier for the [ChooseState].
class ChooseStateNotifier extends StateNotifier<ChooseState> {
  /// Constructs a new instance of [ChooseStateNotifier].
  ChooseStateNotifier()
      : super(
          ChooseState(
            exerciseContent: null,
            workoutContent: null,
            profileImage: null,
            addImage: null,
          ),
        );

  /// Sets the exercise content.
  void setExerciseContent(String content) {
    state = state.copyWith(exerciseContent: content);
  }

  /// Sets the workout content.
  void setWorkoutContent(String? content) {
    state = state.copyWith(workoutContent: content);
  }

  /// Sets the profile image.
  void setProfileImage(String image) {
    state = state.copyWith(profileImage: image);
  }

  /// Sets the additional image.
  void setAddImage(String image) {
    state = state.copyWith(addImage: image);
  }
}

/// Provider for the [ChooseStateNotifier] and [ChooseState].
final chooseProvider = StateNotifierProvider<ChooseStateNotifier, ChooseState>(
  (ref) => ChooseStateNotifier(),
);
