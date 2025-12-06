import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/model/user.dart';
import 'package:pawpal/myconfig.dart';
import 'package:pawpal/pages/home_page.dart';

class SubmitPetScreen extends StatefulWidget {
  final User currentUser;
  const SubmitPetScreen({super.key, required this.currentUser});

  @override
  State<SubmitPetScreen> createState() => _SubmitPetScreenState();
}

class _SubmitPetScreenState extends State<SubmitPetScreen> {
  List<Uint8List?> petImages = [null, null, null];

  String? selectedPetType;
  String? selectedSubmissionCategory;
  late Position myposition;
  bool isLoading = false;

  TextEditingController petNameController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

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
                    width: 300,
                    child: TextField(
                      controller: petNameController,
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
                      initialValue: selectedPetType,
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
                    width: 300,
                    child: TextField(
                      controller: petDescriptionController,
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
                          controller: latitudeController,
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
                          controller: longitudeController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.location_on),
                        onPressed: () async {
                          myposition = await _determinePosition();
                          setState(() {
                            latitudeController.text = myposition.latitude
                                .toStringAsFixed(6);
                            longitudeController.text = myposition.longitude
                                .toStringAsFixed(6);
                          });
                        },
                        iconSize: 50,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  //3 image placeholders
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      placeholderImage(0),
                      SizedBox(width: 10),
                      placeholderImage(1),
                      SizedBox(width: 10),
                      placeholderImage(2),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Upload image button
                  ElevatedButton(
                    onPressed: addImage,
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
                    onPressed: submitPet,
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

  Widget placeholderImage(int index) {
    return GestureDetector(
      onTap: () => pickImage(index),
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: petImages[index] != null ? Colors.grey[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[400] ?? Colors.grey, width: 2),
        ),
        child: petImages[index] != null
            ? Image.memory(petImages[index]!, fit: BoxFit.cover)
            : Icon(Icons.image, size: 40, color: Colors.grey),
      ),
    );
  }

  Future<void> pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        petImages[index] = imageData;
      });
    }
  }

  void addImage() {
    // Find first empty slot
    int emptyIndex = petImages.indexWhere((img) => img == null);

    if (emptyIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum 3 images reached'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    pickImage(emptyIndex);
  }

  void submitPet() {
    // Validate minimum 1 image
    int imageCount = petImages.where((img) => img != null).length;
    if (imageCount < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least 1 image'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (petNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter pet name'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (selectedPetType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select pet type'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (selectedSubmissionCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select submission category'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (petDescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter description'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (petDescriptionController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Description should be at least 10 characters'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (latitudeController.text.isEmpty || longitudeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please set location'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pet submitted successfully!'),
        duration: Duration(seconds: 2),
      ),
    );

    // TODO: Send data to backend with images
    print('Pet Name: ${petNameController.text}');
    print('Pet Type: $selectedPetType');
    print('Category: $selectedSubmissionCategory');
    print('Description: ${petDescriptionController.text}');
    print('Latitude: ${latitudeController.text}');
    print('Longitude: ${longitudeController.text}');
    print('Images count: $imageCount');

    String userId = widget.currentUser.userId!;
    String petName = petNameController.text.trim();
    String petType = selectedPetType!;
    String category = selectedSubmissionCategory!;
    String petDescription = petDescriptionController.text.trim();
    double latitude = double.parse(latitudeController.text);
    double longitude = double.parse(longitudeController.text);
    petImages = petImages.where((img) => img != null).toList();

    uploadPetData(
      userId,
      petName,
      petType,
      category,
      petDescription,
      latitude,
      longitude,
      petImages as List<Uint8List>,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void uploadPetData(
    String userId,
    String petName,
    String petType,
    String category,
    String petDescription,
    double latitude,
    double longitude,
    List<Uint8List> petImages,
  ) async {
    setState(() {
      isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: Colors.orange),
              SizedBox(width: 20),
              Text("Processing..."),
            ],
          ),
        );
      },
    );

    await http
        .post(
          Uri.parse('${MyConfig.baseUrl}/pawpal/api/submit_pet.php'),
          body: {
            'user_id': userId,
            'pet_name': petName,
            'pet_type': petType,
            'category': category,
            'pet_description': petDescription,
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
            'image_paths': jsonEncode(
              petImages.map((img) => base64Encode(img)).toList(),
            ),
          },
        )
        .then((response) {
          if (response.statusCode == 200) {
            var jsonResponse = jsonDecode(response.body);
            if (jsonResponse['status'] == 'success') {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Pet submitted successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );

              if (isLoading) {
                Navigator.of(context).pop(); //close the loading dialog
                setState(() {
                  isLoading = false;
                });
              }

              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Submission failed: ${jsonResponse['message']}',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Server error: ${response.statusCode}'),
                duration: Duration(seconds: 2),
              ),
            );
          }

          if (isLoading) {
            Navigator.of(context).pop();
            setState(() {
              isLoading = false;
            });
          }
        })
        .timeout(
          Duration(seconds: 10),
          onTimeout: () {
            if (!mounted) return;
            SnackBar snackBar = SnackBar(
              content: Text("Request timed out. Please try again."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
  }
}
