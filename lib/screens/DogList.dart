import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dog.dart';
import 'DetailScreen.dart';
import 'AddDogScreen.dart';

class DogListScreen extends StatefulWidget {
  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  List<Dog> dogs = [];

  @override
  void initState() {
    super.initState();
    fetchDogs();
  }

  Future<void> fetchDogs() async {
    final response =
        await http.get(Uri.parse('http://localhost:5001/api/dogs'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        dogs = data.map((dog) => Dog.fromJson(dog)).toList();
      });
    } else {
      throw Exception('Failed to load dogs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dogs List'),
        backgroundColor: const Color.fromARGB(255, 201, 142, 162),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPetScreen()),
              );
            },
          ),
        ],
      ),
      body: dogs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dogs.length,
              itemBuilder: (context, index) {
                final dog = dogs[index];
                return DogCard(
                  dog: dog,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetProfileScreen(dog: dog),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class DogCard extends StatelessWidget {
  final Dog dog;
  final VoidCallback onTap;

  DogCard({required this.dog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 8,
      shadowColor: Colors.pinkAccent, // Ombre rose
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              // Affichage de l'image
             ClipOval(
                child: Image.network(
                  'http://localhost:5001${dog.image}',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              SizedBox(width: 16),
              // Section des détails
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dog.name ?? 'No name provided',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${dog.age} years | ${dog.color}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 18, color: Colors.pinkAccent),
                        SizedBox(width: 4),
                        Text(
                          dog.location ?? 'No location provided',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Genre et temps
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: dog.gender == 'Male'
                          ? Colors.blue[50]
                          : Colors.pink[50],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      dog.gender ?? 'No gender provided',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: dog.gender == 'Male'
                            ? Colors.blue[800]
                            : Colors.pink[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Just now',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
