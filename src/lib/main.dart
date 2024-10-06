import "package:flutter/material.dart";
import "package:harry_potter_points/pages/home.dart";

void main() {
  runApp(
    MaterialApp(
      title: "The Giant Hourglasses",
      routes: {
        "/": (context) => Home(),
      },
      theme: ThemeData(
        useMaterial3: false,
      ),
    )
  );
}

