import 'package:dogs_app/domain/Dog.dart';
import 'package:flutter/material.dart';

import '../screens/detailscreen.dart'; 

class MainScreen extends StatelessWidget {
  final List<Dog> dogs;

  MainScreen({required this.dogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adopet'),
      ),
      body: ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, index) {
          final dog = dogs[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(dog: dog),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(16.0),
                      ),
                      child: Image.asset(
                        dog.image,
                        height: 120.0,
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  dog.name,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  dog.gender == 'Male'
                                      ? Icons.male
                                      : Icons.female,
                                  color: dog.gender == 'Male'
                                      ? Colors.blue
                                      : Colors.pink,
                                  size: 18.0,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'Age: ${dog.age} years',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
