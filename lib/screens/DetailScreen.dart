import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dog.dart';
import 'DogUpdated.dart';

class PetProfileScreen extends StatelessWidget {
  final Dog dog;

  const PetProfileScreen({required this.dog});

  Future<void> _deleteDog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Dog', style: TextStyle(color: Colors.pink)),
        content: Text('Are you sure you want to delete ${dog.name}?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.pink)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: const Color.fromARGB(255, 185, 130, 130))),
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
        title: Text(dog.name ?? 'No name provided',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dog image and details
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      'http://localhost:5001${dog.image}',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dog.name ?? 'No name provided',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildInfoRow(
                            Icons.calendar_today, 'Age', '${dog.age} years'),
                        _buildInfoRow(Icons.male, 'Gender',
                            dog.gender ?? "Not available"),
                        _buildInfoRow(Icons.color_lens, 'Color',
                            dog.color ?? "Not available"),
                        _buildInfoRow(Icons.location_on, 'Location',
                            dog.location ?? "Not available"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // About section
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Me:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        dog.about ?? 'No description available',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Owner details in a horizontal format
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      _buildInfoRow(Icons.person, 'Owner', dog.owner),
                      _buildInfoRow(Icons.description, 'Bio', dog.bio),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _deleteDog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 184, 184),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text('Delete'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _navigateToUpdateScreen(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(icon, color: Colors.pinkAccent),
        SizedBox(width: 8),
        Text(
          '$label: ${value ?? "Not available"}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
