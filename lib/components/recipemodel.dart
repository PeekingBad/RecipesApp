class RecipeModel {
  String recipeName;
  String recipeImage;

  RecipeModel({required this.recipeName, required this.recipeImage});

  static List<RecipeModel> getRecipe() {
    List<RecipeModel> recipe = [];

    recipe.add(RecipeModel(
      recipeName: 'Lasagnette',
      recipeImage: 'assets/images/lasagnette.png',
    ));
    recipe.add(RecipeModel(
      recipeName: 'Penne',
      recipeImage: 'assets/images/penne.png',
    ));
    recipe.add(RecipeModel(
      recipeName: 'Quiche',
      recipeImage: 'assets/images/quiche.png',
    ));
    recipe.add(RecipeModel(
      recipeName: 'Ravioli',
      recipeImage: 'assets/images/ravioli.png',
    ));
    recipe.add(RecipeModel(
      recipeName: 'Risotto',
      recipeImage: 'assets/images/risotto.png',
    ));
    recipe.add(RecipeModel(
      recipeName: 'Shakshuka',
      recipeImage: 'assets/images/shakshuka.png',
    ));
    recipe.add(RecipeModel(
      recipeName: 'tomato ravioli',
      recipeImage: 'assets/images/tomatoravioli.jpg',
    ));

    return recipe;
  }
}
