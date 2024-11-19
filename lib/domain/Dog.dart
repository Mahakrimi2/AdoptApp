import 'Owner.dart';

class Dog {
  int id;
  String name;
  double age;
  String gender;
  String color;
  double weight;
  String location;
  String image; 
  String about;
  Owner owner;
  
  Dog( {
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.location,
    required this.image,
    required this.about,
    required this.owner,
       
  });
}
