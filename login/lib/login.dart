// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:ui';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Safar - Hajj & Umrah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'System',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textOffset;
  late Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));
    
    _textOffset = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.3, 0.6, curve: Curves.easeOut))
    );
    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.6, 0.8, curve: Curves.easeOut))
    );
    
    _logoController.forward();
    
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F6A2F), Color(0xFF0F6A2F), Color(0xFF0a4d21)],
          ),
        ),
        child: Stack(
          children: [
            // Islamic Pattern Background
            Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: IslamicPatternPainter(),
                size: Size.infinite,
              ),
            ),
            // Floating Particles
            ...List.generate(20, (i) => FloatingParticle(
              key: ValueKey('splash_particle_$i'),
              color: const Color(0xFFC8A24A),
              size: 1.0,
              duration: 3 + Random().nextDouble() * 2,
              delay: Random().nextDouble() * 2,
            )),
            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFC8A24A).withOpacity(0.2),
                              blurRadius: 32,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white, Color(0xFFDDE8D8)],
                              ),
                            ),
                            child: const Icon(
                              Icons.home_work,
                              size: 64,
                              color: Color(0xFF0F6A2F),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // App Name
                  SlideTransition(
                    position: _textOffset,
                    child: Column(
                      children: [
                        const Text(
                          'Al-Safar',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 36,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.nightlight_round, size: 16, color: Color(0xFFC8A24A)),
                            const SizedBox(width: 8),
                            const Text(
                              'HAJJ & UMRAH',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 2,
                                color: Color(0xFFDDE8D8),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.nightlight_round, size: 16, color: Color(0xFFC8A24A)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tagline
                  FadeTransition(
                    opacity: _taglineOpacity,
                    child: const Text(
                      'Your Sacred Journey Begins Here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFDDE8D8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Loading Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) => LoadingDot(index: i)),
                  ),
                ],
              ),
            ),
            // Decorative Crescent
            Positioned(
              right: 32,
              top: 80,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: -180, end: 0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value * 3.14159 / 180,
                    child: Opacity(
                      opacity: 0.3,
                      child: const Icon(Icons.nightlight_round, size: 80, color: Color(0xFFC8A24A)),
                    ),
                  );
                },
              ),
            ),
            // Decorative Sparkles
            Positioned(
              left: 32,
              bottom: 80,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 180, end: 0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value * 3.14159 / 180,
                    child: Opacity(
                      opacity: 0.2,
                      child: const Icon(Icons.auto_awesome, size: 64, color: Color(0xFFC8A24A)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingDot extends StatefulWidget {
  final int index;
  const LoadingDot({super.key, required this.index});

  @override
  State<LoadingDot> createState() => _LoadingDotState();
}

class _LoadingDotState extends State<LoadingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 1),
      TweenSequenceItem(tween: ConstantTween<double>(1.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 1),
    ]).animate(_controller);
    _controller.repeat();
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8 * _animation.value,
          height: 8 * _animation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFC8A24A),
          ),
        );
      },
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  bool showPassword = false;
  LoginMethod loginMethod = LoginMethod.phone;
  late AnimationController _headerController;
  late Animation<Offset> _headerOffset;
  late Animation<double> _headerOpacity;
  late AnimationController _cardController;
  late Animation<Offset> _cardOffset;
  late Animation<double> _cardOpacity;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _headerOffset = Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut)
    );
    _headerOpacity = Tween<double>(begin: 0, end: 1).animate(_headerController);
    
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _cardOffset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOut)
    );
    _cardOpacity = Tween<double>(begin: 0, end: 1).animate(_cardController);
    
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _cardController.forward());
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8F3), Color(0xFFDDE8D8)],
          ),
        ),
        child: Stack(
          children: [
            // Pattern Background
            Opacity(
              opacity: 0.05,
              child: CustomPaint(
                painter: IslamicPatternPainter(),
                size: Size.infinite,
              ),
            ),
            // Floating Particles
            ...List.generate(15, (i) => FloatingParticle(
              key: ValueKey('login_particle_$i'),
              color: const Color(0xFFC8A24A),
              size: 1.0,
              duration: 4 + Random().nextDouble() * 3,
              delay: Random().nextDouble() * 2,
              movementRange: 50,
            )),
            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // Top Header
                    SlideTransition(
                      position: _headerOffset,
                      child: FadeTransition(
                        opacity: _headerOpacity,
                        child: Column(
                          children: [
                            // Kaaba Silhouette
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 128,
                                  height: 128,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFC8A24A).withOpacity(0.2),
                                        blurRadius: 24,
                                        spreadRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.nightlife, size: 128, color: Color(0xFF0F6A2F)),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Begin Your Sacred Journey',
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 28,
                                color: Color(0xFF1E2B1F),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Book your Hajj and Umrah experience with ease and confidence.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7A7A7A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Login Card
                    SlideTransition(
                      position: _cardOffset,
                      child: FadeTransition(
                        opacity: _cardOpacity,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.4)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0F6A2F).withOpacity(0.1),
                                  blurRadius: 32,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    children: [
                                      // Method Toggle
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDDE8D8).withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Row(
                                          children: [
                                            _buildMethodToggle(
                                              icon: Icons.phone,
                                              label: 'Phone',
                                              isSelected: loginMethod == LoginMethod.phone,
                                              onTap: () => setState(() => loginMethod = LoginMethod.phone),
                                            ),
                                            _buildMethodToggle(
                                              icon: Icons.email,
                                              label: 'Email',
                                              isSelected: loginMethod == LoginMethod.email,
                                              onTap: () => setState(() => loginMethod = LoginMethod.email),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Input Fields
                                      if (loginMethod == LoginMethod.phone) ...[
                                        const Text(
                                          'Phone Number',
                                          style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F)),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: '+966',
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: '5X XXX XXXX',
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ] else ...[
                                        const Text(
                                          'Email Address',
                                          style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F)),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'your.email@example.com',
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 16),
                                      const Text(
                                        'OTP / Password',
                                        style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F)),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        obscureText: !showPassword,
                                        decoration: InputDecoration(
                                          hintText: 'Enter OTP or Password',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          suffixIcon: IconButton(
                                            icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                                            onPressed: () => setState(() => showPassword = !showPassword),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Remember Me & Forgot
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: true,
                                                onChanged: (v) {},
                                                activeColor: const Color(0xFF0F6A2F),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                              ),
                                              const Text('Remember me', style: TextStyle(color: Color(0xFF1E2B1F))),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                                            },
                                            child: const Text('Forgot?', style: TextStyle(color: Color(0xFF0F6A2F))),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      // Continue Button
                                      TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 1.0, end: 1.02),
                                        duration: const Duration(milliseconds: 200),
                                        builder: (context, scale, child) {
                                          return Transform.scale(
                                            scale: scale,
                                            child: child,
                                          );
                                        },
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const OTPVerificationScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF0F6A2F),
                                            foregroundColor: Colors.white,
                                            minimumSize: const Size(double.infinity, 56),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                            elevation: 8,
                                            shadowColor: const Color(0xFF0F6A2F).withOpacity(0.3),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Continue with OTP'),
                                              SizedBox(width: 8),
                                              Icon(Icons.arrow_forward, size: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Sign Up
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF7A7A7A))),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
                                            },
                                            child: const Text('Sign Up', style: TextStyle(color: Color(0xFF0F6A2F))),
                                          ),
                                          const Text(' or ', style: TextStyle(color: Color(0xFF7A7A7A))),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text('Guest Mode', style: TextStyle(color: Color(0xFF0F6A2F))),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Divider
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 1,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [Colors.transparent, const Color(0xFF0F6A2F).withOpacity(0.2), Colors.transparent],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            child: Text('or continue with', style: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A))),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 1,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [Colors.transparent, const Color(0xFF0F6A2F).withOpacity(0.2), Colors.transparent],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Social Login
                                      Row(
                                        children: [
                                          Expanded(child: _buildSocialButton(Icons.g_mobiledata, Colors.blue)),
                                          const SizedBox(width: 8),
                                          Expanded(child: _buildSocialButton(Icons.facebook, Colors.blue.shade700)),
                                          const SizedBox(width: 8),
                                          Expanded(child: _buildSocialButton(Icons.apple, Colors.black)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Decorative Islamic Arch
                    CustomPaint(
                      size: const Size(100, 40),
                      painter: IslamicArchPainter(),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodToggle({required IconData icon, required String label, required bool isSelected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            boxShadow: isSelected ? [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
            ] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: isSelected ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF0F6A2F).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {},
      ),
    );
  }
}

enum LoginMethod { phone, email }

// OTP Verification Screen
class OTPVerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  const OTPVerificationScreen({super.key, this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> with TickerProviderStateMixin {
  List<String> otp = List.filled(6, '');
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  int timer = 60;
  late AnimationController _headerController;
  late Animation<Offset> _headerOffset;
  late AnimationController _cardController;
  late Animation<Offset> _cardOffset;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _headerOffset = Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut)
    );
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _cardOffset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOut)
    );
    
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _cardController.forward());
    
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && timer > 0) {
        setState(() => timer--);
        return true;
      }
      return false;
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8F2), Color(0xFFDDE8D7)],
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.05,
              child: CustomPaint(
                painter: IslamicPatternPainter(),
                size: Size.infinite,
              ),
            ),
            ...List.generate(10, (i) => FloatingParticle(
              key: ValueKey('otp_particle_$i'),
              color: const Color(0xFFC8A24A),
              size: 1.0,
              duration: 4 + Random().nextDouble() * 3,
              delay: Random().nextDouble() * 2,
              movementRange: 50,
            )),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: const Text('Back'),
                        style: TextButton.styleFrom(foregroundColor: const Color(0xFF0F6A2F)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Header
                    SlideTransition(
                      position: _headerOffset,
                      child: Column(
                        children: [
                          // Shield Icon
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF0F6A2F), Color(0xFF0a4d21)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFC8A24A).withOpacity(0.2),
                                  blurRadius: 24,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.shield, size: 48, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Verify Your Number',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 28,
                              color: Color(0xFF1E2B1F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'We\'ve sent a 6-digit code to',
                            style: TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
                          ),
                          Text(
                            widget.phoneNumber ?? '+966 5X XXX XXXX',
                            style: const TextStyle(fontSize: 14, color: Color(0xFF0F6A2F)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // OTP Card
                    SlideTransition(
                      position: _cardOffset,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white.withOpacity(0.4)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0F6A2F).withOpacity(0.1),
                                blurRadius: 32,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Enter Verification Code',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F)),
                                    ),
                                    const SizedBox(height: 24),
                                    // OTP Input
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(6, (index) => _buildOTPInput(index)),
                                    ),
                                    const SizedBox(height: 24),
                                    // Timer & Resend
                                    if (timer > 0)
                                      Text(
                                        'Resend code in ${timer ~/ 60}:${(timer % 60).toString().padLeft(2, '0')}',
                                        style: const TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
                                      )
                                    else
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            timer = 60;
                                            otp = List.filled(6, '');
                                            _startTimer();
                                            focusNodes[0].requestFocus();
                                          });
                                        },
                                        child: const Text('Resend Code', style: TextStyle(color: Color(0xFFC8A24A))),
                                      ),
                                    const SizedBox(height: 24),
                                    // Verify Button
                                    TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 1.0, end: 1.02),
                                      duration: const Duration(milliseconds: 200),
                                      builder: (context, scale, child) {
                                        return Transform.scale(scale: scale, child: child);
                                      },
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF0F6A2F),
                                          foregroundColor: Colors.white,
                                          minimumSize: const Size(double.infinity, 56),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                          elevation: 8,
                                          shadowColor: const Color(0xFF0F6A2F).withOpacity(0.3),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Verify & Continue'),
                                            SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, size: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Change Number
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Wrong number? Change it', style: TextStyle(color: Color(0xFF7A7A7A))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Security Notice
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A24A).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFC8A24A).withOpacity(0.2)),
                      ),
                      child: const Text(
                        'This code will expire in 10 minutes. Never share your OTP with anyone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Decorative Arch
                    CustomPaint(
                      size: const Size(120, 50),
                      painter: IslamicArchPainter(),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPInput(int index) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: TextEditingController(text: otp[index]),
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF0F6A2F), width: 2),
          ),
        ),
        style: const TextStyle(fontSize: 20, color: Color(0xFF0F6A2F)),
        onChanged: (value) {
          if (value.length > 1) return;
          if (value.isNotEmpty && !RegExp(r'^\d+$').hasMatch(value)) return;
          
          setState(() {
            otp[index] = value;
          });
          
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

// Signup Screen
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with TickerProviderStateMixin {
  int currentStep = 1;
  final int totalSteps = 3;
  Map<String, bool> uploadedFiles = {
    'passport': false,
    'cnic': false,
    'photo': false,
  };
  late AnimationController _headerController;
  late Animation<Offset> _headerOffset;
  late AnimationController _cardController;
  late Animation<Offset> _cardOffset;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _headerOffset = Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut)
    );
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _cardOffset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOut)
    );
    
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _cardController.forward());
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8F2), Color(0xFFDDE8D7)],
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.05,
              child: CustomPaint(
                painter: IslamicPatternPainter(),
                size: Size.infinite,
              ),
            ),
            ...List.generate(12, (i) => FloatingParticle(
              key: ValueKey('signup_particle_$i'),
              color: const Color(0xFFC8A24A),
              size: 1.0,
              duration: 4 + Random().nextDouble() * 3,
              delay: Random().nextDouble() * 2,
              movementRange: 50,
            )),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: const Text('Back to Login'),
                        style: TextButton.styleFrom(foregroundColor: const Color(0xFF0F6A2F)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Header
                    SlideTransition(
                      position: _headerOffset,
                      child: Column(
                        children: [
                          // Decorative Header
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFC8A24A).withOpacity(0.2),
                                  blurRadius: 24,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.nightlife, size: 80, color: Color(0xFF0F6A2F)),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Create Your Pilgrim Account',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 28,
                              color: Color(0xFF1E2B1F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Register to manage Hajj & Umrah bookings, documents and journeys.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Progress Indicator
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildStepIndicator(1, currentStep >= 1),
                              Expanded(child: _buildStepLine(currentStep > 1)),
                              _buildStepIndicator(2, currentStep >= 2),
                              Expanded(child: _buildStepLine(currentStep > 2)),
                              _buildStepIndicator(3, currentStep >= 3),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Personal', style: TextStyle(fontSize: 12, color: currentStep == 1 ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A))),
                              Text('Security', style: TextStyle(fontSize: 12, color: currentStep == 2 ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A))),
                              Text('Documents', style: TextStyle(fontSize: 12, color: currentStep == 3 ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Registration Card
                    SlideTransition(
                      position: _cardOffset,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white.withOpacity(0.4)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0F6A2F).withOpacity(0.1),
                                blurRadius: 32,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 300),
                                      child: _buildStepContent(),
                                    ),
                                    const SizedBox(height: 24),
                                    // Navigation Buttons
                                    Row(
                                      children: [
                                        if (currentStep > 1)
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () => setState(() => currentStep--),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: const Color(0xFF0F6A2F),
                                                side: const BorderSide(color: Color(0xFF0F6A2F)),
                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.arrow_back, size: 20),
                                                  SizedBox(width: 8),
                                                  Text('Previous'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (currentStep > 1) const SizedBox(width: 12),
                                        Expanded(
                                          flex: currentStep > 1 ? 2 : 1,
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween(begin: 1.0, end: 1.02),
                                            duration: const Duration(milliseconds: 200),
                                            builder: (context, scale, child) {
                                              return Transform.scale(scale: scale, child: child);
                                            },
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (currentStep < totalSteps) {
                                                  setState(() => currentStep++);
                                                } else {
                                                  // Create account logic
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF0F6A2F),
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                                elevation: 8,
                                                shadowColor: const Color(0xFF0F6A2F).withOpacity(0.3),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(currentStep == totalSteps ? 'Create Account' : 'Continue'),
                                                  const SizedBox(width: 8),
                                                  const Icon(Icons.arrow_forward, size: 20),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Footer
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? ", style: TextStyle(color: Color(0xFF7A7A7A))),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Sign In', style: TextStyle(color: Color(0xFFC8A24A))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock, size: 12, color: Color(0xFF7A7A7A)),
                            const SizedBox(width: 4),
                            const Text('Secure registration for pilgrims worldwide', style: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A))),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Decorative Arch
                    CustomPaint(
                      size: const Size(120, 50),
                      painter: IslamicArchPainter(),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, bool isActive) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF0F6A2F) : Colors.white,
        border: Border.all(color: isActive ? const Color(0xFF0F6A2F) : const Color(0xFFDDE8D7), width: 2),
      ),
      child: Center(
        child: isActive && currentStep > step
            ? const Icon(Icons.check_circle, size: 20, color: Colors.white)
            : Text(
                step.toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF7A7A7A),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      height: 2,
      color: isActive ? const Color(0xFF0F6A2F) : const Color(0xFFDDE8D7),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return _buildPersonalInfoStep();
      case 2:
        return _buildSecurityStep();
      case 3:
        return _buildDocumentsStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.person, size: 20, color: Color(0xFF0F6A2F)),
            const SizedBox(width: 8),
            const Text('Personal Information', style: TextStyle(fontSize: 18, color: Color(0xFF0F6A2F))),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(label: 'Full Name', hint: 'Enter your full name', icon: Icons.person),
        const SizedBox(height: 16),
        _buildTextField(label: 'Email Address', hint: 'your.email@example.com', icon: Icons.email, keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField(label: 'Code', hint: '+966', icon: Icons.phone, keyboardType: TextInputType.phone)),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: _buildTextField(label: 'Mobile', hint: '5X XXX XXXX', keyboardType: TextInputType.phone)),
          ],
        ),
        const SizedBox(height: 16),
        _buildDropdownField(label: 'Country', hint: 'Select your country', icon: Icons.language),
        const SizedBox(height: 16),
        _buildTextField(label: 'Address', hint: 'Enter your full address', icon: Icons.location_on, maxLines: 3),
      ],
    );
  }

  Widget _buildSecurityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lock, size: 20, color: Color(0xFF0F6A2F)),
            const SizedBox(width: 8),
            const Text('Security', style: TextStyle(fontSize: 18, color: Color(0xFF0F6A2F))),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(label: 'Password', hint: 'Create a strong password', icon: Icons.lock, obscureText: true),
        const SizedBox(height: 16),
        _buildTextField(label: 'Confirm Password', hint: 'Re-enter your password', icon: Icons.lock, obscureText: true),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.warning, size: 20, color: Color(0xFF0F6A2F)),
            const SizedBox(width: 8),
            const Text('Travel & Identity', style: TextStyle(fontSize: 18, color: Color(0xFF0F6A2F))),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(label: 'Emergency Contact', hint: '+966 5X XXX XXXX', icon: Icons.phone, keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        _buildTextField(label: 'CNIC / Passport Number', hint: 'Enter your ID number', icon: Icons.credit_card),
      ],
    );
  }

  Widget _buildDocumentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.upload_file, size: 20, color: Color(0xFF0F6A2F)),
            const SizedBox(width: 8),
            const Text('Document Upload', style: TextStyle(fontSize: 18, color: Color(0xFF0F6A2F))),
          ],
        ),
        const SizedBox(height: 16),
        _buildUploadField(
          label: 'Passport Copy',
          isUploaded: uploadedFiles['passport']!,
          onTap: () => setState(() => uploadedFiles['passport'] = true),
          icon: Icons.upload_file,
          uploadedIcon: Icons.check_circle,
        ),
        const SizedBox(height: 16),
        _buildUploadField(
          label: 'CNIC / ID Card',
          isUploaded: uploadedFiles['cnic']!,
          onTap: () => setState(() => uploadedFiles['cnic'] = true),
          icon: Icons.credit_card,
          uploadedIcon: Icons.check_circle,
        ),
        const SizedBox(height: 16),
        _buildUploadField(
          label: 'Profile Photo',
          isUploaded: uploadedFiles['photo']!,
          onTap: () => setState(() => uploadedFiles['photo'] = true),
          icon: Icons.person,
          uploadedIcon: Icons.check_circle,
        ),
      ],
    );
  }

  Widget _buildTextField({required String label, required String hint, IconData? icon, TextInputType keyboardType = TextInputType.text, bool obscureText = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF1E2B1F))),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF7A7A7A)) : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({required String label, required String hint, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF1E2B1F))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint, style: const TextStyle(color: Color(0xFF7A7A7A))),
              value: null,
              items: const [
                DropdownMenuItem(value: 'sa', child: Text('Saudi Arabia')),
                DropdownMenuItem(value: 'pk', child: Text('Pakistan')),
                DropdownMenuItem(value: 'in', child: Text('India')),
                DropdownMenuItem(value: 'us', child: Text('United States')),
                DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
              ],
              onChanged: (value) {},
              icon: Icon(icon, color: const Color(0xFF7A7A7A)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField({required String label, required bool isUploaded, required VoidCallback onTap, required IconData icon, required IconData uploadedIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF1E2B1F))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isUploaded ? const Color(0xFF0F6A2F).withOpacity(0.05) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUploaded ? const Color(0xFF0F6A2F) : const Color(0xFFDDE8D7),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(isUploaded ? uploadedIcon : icon, size: 32, color: isUploaded ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A)),
                const SizedBox(height: 8),
                Text(
                  isUploaded ? '$label Uploaded' : 'Click to upload $label',
                  style: TextStyle(fontSize: 14, color: isUploaded ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A)),
                ),
                if (!isUploaded)
                  const Text('PDF, JPG, PNG (Max 5MB)', style: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Forgot Password Screen
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with TickerProviderStateMixin {
  ResetMethod resetMethod = ResetMethod.phone;
  late AnimationController _headerController;
  late Animation<Offset> _headerOffset;
  late AnimationController _cardController;
  late Animation<Offset> _cardOffset;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _headerOffset = Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut)
    );
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _cardOffset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOut)
    );
    
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _cardController.forward());
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8F2), Color(0xFFDDE8D7)],
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.05,
              child: CustomPaint(
                painter: IslamicPatternPainter(),
                size: Size.infinite,
              ),
            ),
            ...List.generate(10, (i) => FloatingParticle(
              key: ValueKey('forgot_particle_$i'),
              color: const Color(0xFFC8A24A),
              size: 1.0,
              duration: 4 + Random().nextDouble() * 3,
              delay: Random().nextDouble() * 2,
              movementRange: 50,
            )),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: const Text('Back to Login'),
                        style: TextButton.styleFrom(foregroundColor: const Color(0xFF0F6A2F)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Header
                    SlideTransition(
                      position: _headerOffset,
                      child: Column(
                        children: [
                          // Key Icon
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF0F6A2F), Color(0xFF0a4d21)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFC8A24A).withOpacity(0.2),
                                  blurRadius: 24,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.key, size: 48, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Reset Your Password',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 28,
                              color: Color(0xFF1E2B1F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter your registered email or phone number to receive a reset code',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Reset Card
                    SlideTransition(
                      position: _cardOffset,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white.withOpacity(0.4)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0F6A2F).withOpacity(0.1),
                                blurRadius: 32,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  children: [
                                    // Method Toggle
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDDE8D7).withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        children: [
                                          _buildResetMethodToggle(
                                            icon: Icons.phone,
                                            label: 'Phone',
                                            isSelected: resetMethod == ResetMethod.phone,
                                            onTap: () => setState(() => resetMethod = ResetMethod.phone),
                                          ),
                                          _buildResetMethodToggle(
                                            icon: Icons.email,
                                            label: 'Email',
                                            isSelected: resetMethod == ResetMethod.email,
                                            onTap: () => setState(() => resetMethod = ResetMethod.email),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    // Input Field
                                    if (resetMethod == ResetMethod.phone) ...[
                                      const Text('Phone Number', style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F))),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 96,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: '+966',
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                  borderSide: BorderSide.none,
                                                ),
                                                prefixIcon: const Icon(Icons.phone, size: 16, color: Color(0xFF7A7A7A)),
                                                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: '5X XXX XXXX',
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                  borderSide: BorderSide.none,
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ] else ...[
                                      const Text('Email Address', style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F))),
                                      const SizedBox(height: 8),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'your.email@example.com',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                          prefixIcon: const Icon(Icons.email, color: Color(0xFF7A7A7A)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 24),
                                    // Send Code Button
                                    TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 1.0, end: 1.02),
                                      duration: const Duration(milliseconds: 200),
                                      builder: (context, scale, child) {
                                        return Transform.scale(scale: scale, child: child);
                                      },
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF0F6A2F),
                                          foregroundColor: Colors.white,
                                          minimumSize: const Size(double.infinity, 56),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                          elevation: 8,
                                          shadowColor: const Color(0xFF0F6A2F).withOpacity(0.3),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Send Reset Code'),
                                            SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, size: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Help Text
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Remember your password? ', style: TextStyle(color: Color(0xFF7A7A7A))),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Sign In', style: TextStyle(color: Color(0xFFC8A24A))),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A24A).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFC8A24A).withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.key, size: 16, color: Color(0xFFC8A24A)),
                              const SizedBox(width: 8),
                              const Text('What happens next?', style: TextStyle(fontSize: 14, color: Color(0xFF1E2B1F))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('• You\'ll receive a 6-digit verification code\n• Enter the code to verify your identity\n• Create a new secure password',
                            style: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Decorative Arch
                    CustomPaint(
                      size: const Size(120, 50),
                      painter: IslamicArchPainter(),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResetMethodToggle({required IconData icon, required String label, required bool isSelected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            boxShadow: isSelected ? [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
            ] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: isSelected ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? const Color(0xFF0F6A2F) : const Color(0xFF7A7A7A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ResetMethod { phone, email }

// Custom Painters
class IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0F6A2F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += 100) {
      for (double y = 0; y < size.height; y += 100) {
        // Draw star shape
        final path = Path();
        path.moveTo(x + 50, y + 10);
        path.lineTo(x + 60, y + 30);
        path.lineTo(x + 80, y + 30);
        path.lineTo(x + 65, y + 42);
        path.lineTo(x + 70, y + 62);
        path.lineTo(x + 50, y + 48);
        path.lineTo(x + 30, y + 62);
        path.lineTo(x + 35, y + 42);
        path.lineTo(x + 20, y + 30);
        path.lineTo(x + 40, y + 30);
        path.close();
        canvas.drawPath(path, paint);
        
        // Draw circle
        canvas.drawCircle(Offset(x + 50, y + 50), 30, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class IslamicArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC8A24A).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.375, size.width * 0.5, size.height * 0.375);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.375, size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floating Particle Widget
class FloatingParticle extends StatefulWidget {
  final Color color;
  final double size;
  final double duration;
  final double delay;
  final double movementRange;
  
  const FloatingParticle({
    super.key,
    required this.color,
    required this.size,
    required this.duration,
    required this.delay,
    this.movementRange = 100,
  });

  @override
  State<FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<FloatingParticle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _yAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _xAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.duration * 1000).round()),
    );
    
    _yAnimation = Tween<double>(
      begin: 0,
      end: (_random.nextDouble() - 0.5) * widget.movementRange,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    _xAnimation = Tween<double>(
      begin: 0,
      end: (_random.nextDouble() - 0.5) * (widget.movementRange * 0.6),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween<double>(0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.4), weight: 1),
      TweenSequenceItem(tween: ConstantTween<double>(0.4), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 0), weight: 1),
    ]).animate(_controller);
    
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) _controller.repeat();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _random.nextDouble() * MediaQuery.of(context).size.width,
      top: _random.nextDouble() * MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_xAnimation.value, _yAnimation.value),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



