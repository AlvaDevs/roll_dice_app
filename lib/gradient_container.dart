import 'package:flutter/material.dart';
import 'package:roll_dice_app/dice_roller.dart';

/// A container widget that displays a gradient background
///
/// Takes two colors to create a linear gradient from top-left to bottom-right
/// and centers its child widget in the middle of the screen.
class GradientContainer extends StatelessWidget {
  /// Constructs a gradient container with specified colors
  ///
  /// [color1] - Starting color for the gradient
  /// [color2] - Ending color for the gradient
  /// [key] - Optional widget key for identification
  const GradientContainer(this.color1, this.color2, {super.key});

  /// The starting color of the linear gradient
  final Color color1;

  /// The ending color of the linear gradient
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
      ),
      child: const Center(
        // Main content centered in the screen
        child: DiceRoller(),
      ),
    );
  }
}
