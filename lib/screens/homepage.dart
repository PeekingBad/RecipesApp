import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cookbook/components/recipemodel.dart';
import '../constants.dart';
import '../screens/recipepage.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

// Vraag toestemming aan de gebruiker


class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<RecipeModel> recipes = [];

  void _getRecipes() {
    recipes = RecipeModel.getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    _getRecipes();
    return Scaffold(
      appBar: appBar(),
      body: _gridImages(),
    );
  }

  GridView _gridImages() {
    return GridView.builder(
      itemCount: recipes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Navigeer naar de volgende pagina wanneer op een item wordt geklikt
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RecipePage(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Stack(
              children: [
                // Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: AssetImage(recipes[index].recipeImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Tekst overlay
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      recipes[index].recipeName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Home",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: turqoise,
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          _showAddDialog();
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
            width: 40,
            child: Image.asset(
              'assets/images/account.png',
              height: 30,
              width: 30,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }

Future<void> _showAddDialog() async {
    TextEditingController _nameController = TextEditingController();
    File? _image;

    // Vraag toestemming aan de gebruiker
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    // Controleer of de toestemming is verleend voor camera en opslag
    if (statuses[Permission.camera] != PermissionStatus.granted ||
        statuses[Permission.storage] != PermissionStatus.granted) {
      // Toestemming niet verleend, toon een melding of handel anderszins
      print('Toestemming niet verleend voor camera of opslag.');
      return; // Stop de functie als de toestemming niet is verleend
    }

    // Toon het dialoogvenster om een nieuw gerecht toe te voegen
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voeg een nieuw gerecht toe'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Naam van het gerecht',
                  ),
                ),
                SizedBox(height: 10),
                _image == null
                    ? Text('Voeg een afbeelding toe')
                    : Image.file(_image!),
                TextButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                      } else {
                        print('Geen afbeelding geselecteerd.');
                      }
                    });
                  },
                  child: Text('Selecteer een afbeelding'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuleren'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Toevoegen'),
              onPressed: () {
                // Voeg hier de logica toe om het gerecht toe te voegen
                // bijvoorbeeld:
                recipes.add(RecipeModel(
                  recipeName: _nameController.text,
                  recipeImage: _image!.path,
                ));
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

}
