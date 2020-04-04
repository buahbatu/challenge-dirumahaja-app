class Profile {
  final String username;
  final int age;
  final bool isMale;
  final String challenger;
  final String coordinate;

  Profile({
    this.username,
    this.age,
    this.isMale,
    this.challenger,
    this.coordinate,
  });

  Profile copyWith({
    String username,
    int age,
    bool isMale,
    String challenger,
    String coordinate,
  }) {
    return Profile(
      username: username ?? this.username,
      age: age ?? this.age,
      isMale: isMale ?? this.isMale,
      challenger: challenger ?? this.challenger,
      coordinate: coordinate ?? this.coordinate,
    );
  }
}
