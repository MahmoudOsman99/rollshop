import 'package:flutter/material.dart';

class InstaPayLoading extends StatefulWidget {
  const InstaPayLoading({super.key});

  @override
  State<InstaPayLoading> createState() => _InstaPayLoadingState();
}

class _InstaPayLoadingState extends State<InstaPayLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Adjust duration as needed
    )..repeat(reverse: true); // Repeat the animation

    _opacityAnimation = Tween<double>(begin: 0.2, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Background color
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                width: 150, // Adjust size as needed
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.3), // Background pulse color
                ),
              ),
            ),
            const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.blue), // Indicator color
              strokeWidth: 4, // Adjust stroke width as needed
            ),
          ],
        ),
      ),
    );
  }
}
