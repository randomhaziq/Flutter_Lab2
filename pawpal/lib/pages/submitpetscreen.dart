import 'package:flutter/material.dart';

class SubmitPetScreen extends StatefulWidget {
  const SubmitPetScreen({super.key});

  @override
  State<SubmitPetScreen> createState() => _SubmitPetScreenState();
}

class _SubmitPetScreenState extends State<SubmitPetScreen> {
  String? selectedPetType;
  String? selectedSubmissionCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Adoption")),
      body: Row(
        children: [
          // Left side image
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.orange[100],
              child: Center(
                child: Image.asset(
                  'assets/images/.png', // TODO: change image
                  width: 500,
                  height: 500,
                ),
              ),
            ),
          ),

          // Right side submit pet form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Submit Your Pet for Adoption',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bubblegum Sans',
                    ),
                  ),
                  SizedBox(height: 30),

                  // Pet Name field
                  SizedBox(
                    width: 300, // Constrain width
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Pet Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Dropdown for pet type
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Pet Type',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedPetType,
                      items: <String>['Dog', 'Cat', 'Other'].map((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPetType = newValue;
                        });
                      },
                      hint: const Text('Select Pet Type'),
                    ),
                  ),
                  SizedBox(height: 20),

                  //dropdown for submission type
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Submission Category',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          <String>[
                            'Adoption',
                            'Donation Request',
                            'Help/ Rescue',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubmissionCategory = newValue;
                        });
                      },
                      hint: const Text('Select Submission Category'),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Description field
                  SizedBox(
                    width: 300, // Constrain width
                    child: TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //latitue and longitude fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on,
                        size: 50,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  //3 image placeholders
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Upload image button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement image upload functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      '+ Add Image',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Submit button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement submit functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
