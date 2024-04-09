import 'package:cookbook/components/recipemodel.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/recipepage.dart';

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
   Homepage({Key? key}) : super(key: key);


  List<RecipeModel> recipes = [];

   void _getRecipes(){
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
                  builder: (context) =>
                      const RecipePage()), // Vervang NextPage door de naam van je volgende pagina
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
                      color: Colors.black
                          .withOpacity(0.5), // Zwarte overlay met opacity
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
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      backgroundColor: turqoise,
      centerTitle: true,
      elevation: 0.0,
      actions: [
        GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          width: 40,
          child: Image.asset('assets/images/account.png',
          height: 30,
          width: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
        ),  
        )
        ],
    );
  }
}
