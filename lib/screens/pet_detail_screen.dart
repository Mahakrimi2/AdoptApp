import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dog.dart';
import 'update_dog.dart';

class PetProfileScreen extends StatelessWidget {
  final Dog dog;

  const PetProfileScreen({required this.dog});

  Future<void> _deleteDog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Dog'),
        content: Text('Are you sure you want to delete ${dog.name}?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () async {
              try {
                final response = await http.delete(
                  Uri.parse('http://localhost:5001/api/dogs/${dog.id}'),
                );

                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${dog.name} has been deleted')),
                  );
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                } else {
                  throw Exception('Failed to delete dog');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _navigateToUpdateScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDogScreen(dog: dog),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name ?? 'No name provided'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dog.name ?? 'No name provided',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.cake, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('${dog.age} years old'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.male, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(dog.gender ?? 'Not Available'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.color_lens, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(dog.color ?? 'Not Available'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(dog.location ?? 'Not Available'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  SizedBox(width: 16),
                  // Affichage de l'image
                  Image.network(
                    'http://localhost:5001${dog.image}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About me:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(color: Colors.teal, thickness: 1),
                      Text(
                        dog.about ?? 'No description available',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Owner Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(dog.name ?? 'No name provided'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        dog.bio ?? 'No name provided',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _deleteDog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToUpdateScreen(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      
                    ),
                    child: Text('Update'),
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
