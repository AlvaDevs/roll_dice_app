import 'dart:math';
import 'package:flutter/material.dart';

// Random number generator for dice rolls
final randomizer = Random();

/// A widget that displays an interactive dice with roll animations
///
/// Features:
/// - Tap to roll the dice
/// - 3D rotation animation when rolling
/// - Scaling effect during animation
/// - Displays random dice faces (1-6)
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

/// State class for managing dice roll animations and interactions
class _DiceRollerState extends State<DiceRoller> with TickerProviderStateMixin {
  // Configuration constants
  static const _diceSize = 200.0; // Visual size of the dice
  static const _animationDuration = 500; // Milliseconds for animation

  // Current visible dice face (1-6)
  var _currentDice = 1;

  // Controller for managing the spin animation
  late final AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller with vsync for frame synchronization
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _animationDuration),
    );
  }

  /// Handles the dice roll action
  void _rollDice() {
    // Generate new random dice value (1-6)
    final newDice = randomizer.nextInt(6) + 1;

    // Update state only if the value changes
    if (newDice != _currentDice) {
      setState(() {
        _currentDice = newDice;
      });
    }

    // Trigger animation sequence
    _spinController.forward(from: 0).then((_) {
      _spinController.reset();
    });
  }

  @override
  void dispose() {
    // Clean up animation controller when widget is removed
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated dice container
        AnimatedBuilder(
          animation: _spinController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _spinController.value * 2 * pi, // Full rotation
              child: Transform.scale(
                scale: 1 + (_spinController.value * 0.2), // Scale effect
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/images/dice-$_currentDice.png',
            width: _diceSize,
            height: _diceSize,
          ),
        ),

        // Roll button
        const SizedBox(height: 20),
        TextButton(
          onPressed: _rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
