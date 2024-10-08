// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class HouseCard extends StatefulWidget {
  String house;
  int points;
  Color? colour;
  Color? accent;
	String crest;
  HouseCard(
      {super.key,
      required this.house,
      required this.points,
      required this.colour,
      required this.accent,
			required this.crest});

  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Animation> padAnimation = [];
	bool front = true;
  bool hover = false;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    padAnimation = [
      Tween<double>(begin: 20, end: 10).animate(animationController),
      Tween<double>(begin: 20, end: 30).animate(animationController)
    ];
    animationController.addListener(() {
      setState(() {});
    });
  }

  void activateAnimation(bool value) {
    value ? animationController.forward() : animationController.reverse();
    setState(() {front = !front; hover = value;});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, padAnimation[0].value, 20, padAnimation[1].value),
      child: Card(
        color: widget.colour,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.accent!, width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.landscape ? 0.15 : 0.7),
          height: MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape ? 0.4 : 0.6),
          child: TextButton(
            onPressed: () {
              if (MediaQuery.of(context).orientation == Orientation.portrait) {
                setState(() {
                  front = !front;
                });
              }
						},
            onHover: (value) => activateAnimation(value),
            style: ButtonStyle(
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: !front ? [
                  Text(
                    widget.house,
                    style: TextStyle(
                        color: widget.accent,
                        fontFamily: GoogleFonts.jost().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Text(
                    widget.points.toString(),
                    style: TextStyle(
                        color: widget.accent,
                        fontFamily: GoogleFonts.jost().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  )
                ] : [
									Image(image: NetworkImage(widget.crest), fit: BoxFit.contain)
								]),
          ),
        ),
      ),
    );
  }
}
