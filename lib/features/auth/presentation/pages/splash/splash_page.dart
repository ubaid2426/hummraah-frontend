import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hummraah/features/auth/presentation/pages/Login_Page/get_stated_screen.dart';
// import '../testimonials/dashboard/main_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GetStartedScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const  Color(0xFF007F5F) ,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img01.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const  Color(0xFF007F5F) );
              },
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                     Color(0xFF007F5F) .withOpacity(0.85),
                     Color(0xFF007F5F) .withOpacity(0.95),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC5A059),
                      width: 1.5,
                    ),
                    color: Colors.white.withOpacity(0.05),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mosque_outlined,
                        size: 50,
                        color: Color(0xFFC5A059),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'UMRAH',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                      Text(
                        'TRAVELS',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFC5A059),
                          letterSpacing: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
