class Dog {
  String? id;
  String? name;
  int? age;
  String? gender;
  String? color;
  double? weight;
  String? location;
  String? about;
  String? owner;
  String? bio;
  String? image;

  Dog({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.color,
    this.weight,
    this.location,
    this.about,
    this.owner,
    this.bio,
    this.image
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
        id: json['_id'] ?? 'is not available',
        name: json['name'] ?? '',
        age: (json['age'] is int) ? json['age'] : 0,
        gender: json['gender'] ?? 'Unknown',
        color: json['color'] ?? '',
        weight: (json['weight'] is double) ? json['weight'] : 0.0,
        location: json['location'] ?? '',
        about: json['about'] ?? '',
        owner: json['owner'] ?? '',
        bio: json['bio'] ?? '',
        image : json['image'] ?? '',
);
  }
}
