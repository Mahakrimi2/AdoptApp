import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AddPetScreen extends StatefulWidget {
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerBioController = TextEditingController();

  String _gender = 'Male'; // Default value for gender

  Uint8List? _pickedImageBytes;
  String? _pickedImageName;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _colorController.dispose();
    _weightController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    _ownerNameController.dispose();
    _ownerBioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _pickedImageBytes = bytes;
          _pickedImageName = image.name;
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final url = Uri.parse('http://localhost:5001/api/dogs');
      final request = http.MultipartRequest('POST', url);

      // Add form fields
      request.fields['name'] = _nameController.text.trim();
      request.fields['age'] = _ageController.text.trim();
      request.fields['gender'] = _gender;
      request.fields['color'] = _colorController.text.trim();
      request.fields['weight'] = _weightController.text.trim();
      request.fields['location'] = _locationController.text.trim();
      request.fields['about'] = _aboutController.text.trim();
      request.fields['owner'] = _ownerNameController.text.trim();
      request.fields['bio'] = _ownerBioController.text.trim();

      // Add image if selected
      if (_pickedImageBytes != null && _pickedImageName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image', // Correspond au champ attendu par l'API
          _pickedImageBytes!,
          filename: _pickedImageName,
        ));
      }

      try {
        final response = await request.send();
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Dog added successfully!')),
          );
          _formKey.currentState?.reset();
          setState(() {
            _pickedImageBytes = null;
            _pickedImageName = null;
          });
        } else {
          final responseBody = await response.stream.bytesToString();
          final errorMessage =
              json.decode(responseBody)['message'] ?? 'An error occurred.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add Dog: $errorMessage')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dog'), // Titre modifié à "Rôle"
        backgroundColor: const Color.fromARGB(255, 199, 147, 165),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined), // Modern icon style
            onPressed: _submitForm,
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 236, 157, 190),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _pickedImageBytes != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(400), // Rondir l'image
                        child: Image.memory(
                          _pickedImageBytes!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons
                              .image_outlined, // Nouveau icône moderne pour l'image
                          size: 100,
                          color: Colors.grey[600],
                        ),
                      ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 204, 155, 171),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
                _buildTextField('Dog Name', _nameController, Icons.pets),
                _buildTextField('Age', _ageController, Icons.cake_outlined,
                    isNumber: true),
                _buildTextField(
                    'Color', _colorController, Icons.color_lens_outlined),
                _buildTextField('Weight (kg)', _weightController,
                    Icons.line_weight_outlined,
                    isNumber: true),
                _buildGenderDropdown(),
                _buildTextField('Location', _locationController,
                    Icons.location_on_outlined),
                _buildTextField(
                    'About', _aboutController, Icons.description_outlined,
                    maxLines: 3),
                _buildTextField('Owner Name', _ownerNameController,
                    Icons.account_circle_outlined),
                _buildTextField(
                    'Owner Bio', _ownerBioController, Icons.info_outline,
                    maxLines: 2),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 204, 152, 188),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink),
          filled: true,
          fillColor: Colors.pink[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pink, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pink[700]!, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: _gender,
        onChanged: (value) => setState(() => _gender = value!),
        items: ['Male', 'Female'].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Gender',
          filled: true,
          fillColor: Colors.pink[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pink, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pink[700]!, width: 2),
          ),
        ),
      ),
    );
  }
}
