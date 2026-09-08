import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/rooms/c2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            final maxContentWidth = isTablet ? 500.0 : double.infinity;
            final titleFontSize = isTablet ? 32.0 : 24.0;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 0 : 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Découvrez nos chambres d\'hôtel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Voir nos chambres',
                          onPressed: () => context.push('/rooms'),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
