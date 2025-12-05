import 'package:flutter/material.dart';
import 'Package:pawpal/model/pet.dart';

class BrowsePets extends StatefulWidget {
  const BrowsePets({super.key});

  @override
  State<BrowsePets> createState() => _BrowsePetsState();
}

class _BrowsePetsState extends State<BrowsePets> {
  Pet pet = Pet(); //TODO: fetch from backend
  int maxPets = 25; //TODO: fetch from backend and convert to list

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
                  SizedBox(width: 400),

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
            child: ListView.builder(
              itemCount: (maxPets / 2).ceil(),

              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                int firstIndex = index * 2;
                int secondIndex = firstIndex + 1;

                return Row(
                  children: [
                    Expanded(child: showPetCard(firstIndex)),
                    Expanded(
                      child: secondIndex < maxPets
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
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(pet.imagePaths ?? 'assets/default_pet.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Icon(Icons.pets, size: 50, color: Colors.orange[400]),
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
}
