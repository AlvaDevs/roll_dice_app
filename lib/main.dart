import 'package:flutter/material.dart';
import 'package:roll_dice_app/gradient_container.dart';

/// Entry point of the application
///
/// Initializes the Flutter framework and sets up the root widget
void main() {
  runApp(
    const MaterialApp(
      // Main screen configuration
      home: Scaffold(
        // Full-screen gradient background container
        body: GradientContainer(
          // Primary gradient color (RGB: 255, 89, 94 - Coral)
          Color.fromRGBO(255, 89, 94, 1),
          // Secondary gradient color (RGB: 106, 76, 147 - Purple)
          Color.fromRGBO(106, 76, 147, 1),
        ),
      ),
    ),
  );
}
