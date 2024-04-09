import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cookbook/components/recipemodel.dart';
import '../constants.dart';
import '../screens/recipepage.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

// Vraag toestemming aan de gebruiker

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          TextEditingController _userInput = new TextEditingController();
          addRecipe(_userInput);
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/account.png',
              height: 30,
              width: 30,
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> addRecipe(TextEditingController _userInput) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        children: [
          AlertDialog(
            title: Text('Add your recipe'),
            content: Column(
              children: [
                TextField(
                  controller: _userInput,
                  decoration: InputDecoration(labelText: 'Name of your recipe'),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Achtergrondkleur instellen op blauw
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.add_circle_rounded, color: Colors.white,), // Icon
                        SizedBox(width: 8),
                        Text('Choose an image', style: TextStyle(color: Colors.white),), // Tekst
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Achtergrondkleur instellen op blauw
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.add_circle_rounded, color: Colors.white,), // Icon
                        SizedBox(width: 8),
                        Text('Take a photo', style: TextStyle(color: Colors.white),), // Tekst
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                image != null ? Image.file(image!, width: 160, height: 160, fit: BoxFit.cover,) : FlutterLogo()
                
              ],
            ),
            
            actions: [
              TextButton(
               child: const Text('Cancel'),
               onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  recipes.add(RecipeModel(
                    recipeName: _userInput.text, 
                    recipeImage: image!.path),
                    );
                    Navigator.of(context).pop();
                    setState(() {
                      
                    });
                },
              ),
            ],
          ),
        ],
      ),
      
    );
  }
}
