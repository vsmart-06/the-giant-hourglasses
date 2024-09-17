import "package:flutter/material.dart";
import "package:harry_potter_points/pages/home.dart";

void main() {
  runApp(
    MaterialApp(
      routes: {
        "/": (context) => Home(),
      },
      theme: ThemeData(
        useMaterial3: false,
      ),
    )
  );
}

