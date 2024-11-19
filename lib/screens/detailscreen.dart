import 'package:dogs_app/domain/Dog.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Dog dog;

  const DetailScreen({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0), 
              child: Image.asset(
                dog.image,
                fit: BoxFit.cover,
                height: 250.0,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 16),
           
            Row(
              children: [
                Text(
                  dog.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  dog.gender == 'Male' ? Icons.male : Icons.female,
                  color: dog.gender == 'Male' ? Colors.blue : Colors.pink,
                  size: 24.0,
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 18.0,
                ),
                SizedBox(width: 4.0),
                Text(
                  dog.location,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('12min ago'),
                Spacer(),
                Text(
                  '${dog.age} years',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'About me',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              dog.about,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Quick Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _buildDetailRow('Age', '${dog.age} years'),
                SizedBox(width: 16),
                _buildDetailRow('Color', dog.color),
                SizedBox(width: 16),
                _buildDetailRow('Weight', '${dog.weight} kg'),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
