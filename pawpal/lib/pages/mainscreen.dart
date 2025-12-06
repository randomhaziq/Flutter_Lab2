import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawpal/model/pet.dart';
import 'package:pawpal/model/user.dart';
import 'package:pawpal/myconfig.dart';
import 'package:pawpal/pages/submitPetScreen.dart';

class BrowsePets extends StatefulWidget {
  const BrowsePets({super.key});

  @override
  State<BrowsePets> createState() => _BrowsePetsState();
}

class _BrowsePetsState extends State<BrowsePets> {
  User? currentUser;
  List<Pet> listPets = [];
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Browse Pets")),
      body: Column(
        children: [
          //top section
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 184, 204, 219),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "PawPal",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bubblegum Sans',
                    ),
                  ),
                  SizedBox(width: 20),

                  //search bar
                  SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.cancel),
                        labelText: 'Search Pets',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => searchPets(value),
                    ),
                  ),
                  SizedBox(width: 20),

                  // Submit Pet Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitPetScreen(
                            currentUser: currentUser ?? User(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Submit Pet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 200),

                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bubblegum Sans',
                    ),
                  ),
                  SizedBox(width: 20),

                  //icon for categories
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange[200],
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('cat_category.png'),
                        ),
                        SizedBox(width: 10),

                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange[200],
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('dog_category.png'),
                        ),
                        SizedBox(width: 10),

                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange[200],
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('bird_category.png'),
                        ),
                        SizedBox(width: 10),

                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange[200],
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('other_category.png'),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //bottom section
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : listPets.isEmpty
                ? Center(child: Text('No pets available'))
                : ListView.builder(
                    itemCount: (listPets.length / 2).ceil(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      int firstIndex = index * 2;
                      int secondIndex = firstIndex + 1;

                      return Row(
                        children: [
                          Expanded(child: showPetCard(firstIndex)),
                          Expanded(
                            child: secondIndex < listPets.length
                                ? showPetCard(secondIndex)
                                : Container(),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void searchPets(String value) {}

  Widget showPetCard(int index) {
    if (index >= listPets.length) {
      return Container();
    }

    Pet pet = listPets[index];
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            image: (pet.imagePaths != null && pet.imagePaths!.isNotEmpty)
                ? DecorationImage(
                    image: NetworkImage(pet.imagePaths![0]),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: (pet.imagePaths == null || pet.imagePaths!.isEmpty)
              ? Icon(Icons.pets, size: 50, color: Colors.orange[400])
              : null,
        ),

        title: Text(pet.petName ?? 'Pet Name'),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${pet.petType ?? 'Unknown'}'),
            Text('Category: ${pet.category ?? 'Unknown'}'),
            Text(
              'Description: ${pet.petDescription ?? 'No description'}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadPets() async {
    try {
      final fetchedPets = await http.get(
        Uri.parse('${MyConfig.baseUrl}/pawpal/api/get_my_pets.php'),
      );

      var resArray = jsonDecode(fetchedPets.body);
      if (resArray['status'] == 'success') {
        var petsData = resArray['data'] as List;
        setState(() {
          isLoading = false;
          listPets = petsData.map((petJson) => Pet.fromJson(petJson)).toList();
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
