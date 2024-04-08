import 'package:flutter/material.dart';
import '../constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ), 
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: 
          Padding(
            padding: const EdgeInsets.all(13),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              color: turqoise,
              ),
              child: Center(
                child: Text(
                  'Item $index',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                ),
            ),
          ),
          );
        },
      ),
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
