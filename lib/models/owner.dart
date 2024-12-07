class Owner {
  final String name;
  final String bio;

  Owner({
    required this.name,
    required this.bio,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'],
      bio: json['bio'],
    );
  }
}