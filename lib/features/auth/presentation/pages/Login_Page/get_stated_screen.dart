import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hummraah/features/auth/presentation/pages/home/home_screen.dart';
import 'dart:math' as math;

import 'singup_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2E7D32).withOpacity(0.15),
              const Color(0xFF1B5E20).withOpacity(0.08),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFF2E7D32).withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFD4AF37).withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2E7D32),
                                        Color(0xFF1B5E20),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF2E7D32)
                                            .withOpacity(0.4),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons. mosque_rounded,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: const Text(
                                    'Welcome to',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1B5E20),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Text(
                                    'Hummraah',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: [
                                            Color(0xFF2E7D32),
                                            Color(0xFFD4AF37),
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 70),
                                        ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40 * (1 - value),
                                  ),
                                  child: const Text(
                                    'Your trusted companion for Umrah & Hajj journey',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF6B6B7A),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation, _) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: const HomeScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: const Text(
                                'Start Your Journey',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(color: Color(0xFF6B6B7A)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation, _) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: const LoginScreen(),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Color(0xFF2E7D32),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
