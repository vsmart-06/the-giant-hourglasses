import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:harry_potter_points/widgets/house_card.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Giant Hourglasses",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.jost().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ), 
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.deepPurple[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HouseCard(house: "Gryffindor", points: 0, colour: Color(0xFF740001), accent: Color(0xFFD3A625), crest: "https://i.imgur.com/e5yoXUs.png"),
              HouseCard(house: "Hufflepuff", points: 0, colour: Color(0xFFFFD800), accent: Colors.black, crest: "https://i.imgur.com/6va7uxA.png"),
              HouseCard(house: "Ravenclaw", points: 0, colour: Color(0x0E1A40), accent: Color(0xFF946B2D), crest: "https://i.imgur.com/9RKkW4j.png"),
              HouseCard(house: "Slytherin", points: 0, colour: Color(0xFF1A472A), accent: Color(0xFF5D5D5D), crest: "https://i.imgur.com/KPORQ6B.png"),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mic),
        tooltip: "Change points for a house",
        onPressed: () {},
      ),
    );
  }
}