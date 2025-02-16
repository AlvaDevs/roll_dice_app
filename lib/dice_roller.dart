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
/// - Responsive design for all platforms
/// - Displays random dice faces (1-6)
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

/// State class for managing dice roll animations and interactions
class _DiceRollerState extends State<DiceRoller> with TickerProviderStateMixin {
  // Configuration constants
  static const _baseAnimationDuration = 500; // Milliseconds for animation
  static const _maxMobileWidth = 600.0; // Breakpoint for responsive design

  // Current visible dice face (1-6)
  var _currentDice = 1;

  // Animation controllers
  late final AnimationController _spinController;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _baseAnimationDuration),
    );

    // Configure animations
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(
      parent: _spinController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _spinController,
      curve: Curves.easeInOut,
    ));
  }

  /// Handles the dice roll action
  void _rollDice() {
    // Generate new random dice value (1-6)
    final newDice = randomizer.nextInt(6) + 1;

    setState(() => _currentDice = newDice);

    // Reset and restart animation
    _spinController.reset();
    _spinController.forward();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive sizing calculations
        final isDesktop = constraints.maxWidth > _maxMobileWidth;
        final double diceSize = isDesktop
            ? constraints.maxWidth * 0.25
            : min(constraints.maxWidth * 0.8, 300);

        // Responsive text sizing
        final textScale = isDesktop ? 1.5 : 1.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated dice container
            AnimatedBuilder(
              animation: _spinController,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..rotateZ(_rotationAnimation.value)
                    ..scale(_scaleAnimation.value),
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/dice-$_currentDice.png',
                width: diceSize,
                height: diceSize,
                filterQuality: FilterQuality.high,
              ),
            ),

            // Roll button with responsive padding
            Padding(
              padding: EdgeInsets.only(top: diceSize * 0.1),
              child: TextButton(
                onPressed: _rollDice,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 24 * textScale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Roll Dice'),
              ),
            ),
          ],
        );
      },
    );
  }
}
