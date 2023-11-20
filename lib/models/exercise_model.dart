class Exercise {
  final String? name;
  final String? description;
  final String? exerciseImage;
  final Map<String, dynamic>? sets;

  Exercise({
    this.name,
    this.description,
    this.sets,
    this.exerciseImage,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      description: map['description'],
      sets: map['sets'],
      exerciseImage: map['exerciseImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'sets': sets,
      'exerciseImage': exerciseImage,
    };
  }
}
