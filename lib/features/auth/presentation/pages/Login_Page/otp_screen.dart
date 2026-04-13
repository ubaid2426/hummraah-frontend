
import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  int _timerSeconds = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
        _startTimer();
      } else {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      _timerSeconds = 30;
      _canResend = false;
    });
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New verification code sent to your email!'),
        backgroundColor: Color(0xFF2E7D32),
      ),
    );
  }

  void _verifyOTP() {
    String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: const HomeScreen(),
            );
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 6-digit verification code'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2E7D32).withOpacity(0.08),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                ScaleTransition(
                  scale: _pulseController,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32).withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.sms_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Column(
                        children: [
                          const Text(
                            'Verify Your Email',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'We\'ve sent a verification code to',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xFF6B6B7A),
                            ),
                          ),
                          Text(
                            widget.email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF2E7D32).withOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2E7D32),
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 5) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index + 1]);
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index - 1]);
                                }
                                if (index == 5 && value.length == 1) {
                                  _verifyOTP();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _canResend ? "Didn't receive code? " : "Resend code in $_timerSeconds s",
                      style: const TextStyle(color: Color(0xFF6B6B7A)),
                    ),
                    if (_canResend)
                      GestureDetector(
                        onTap: _resendCode,
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _verifyOTP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Verify & Continue',
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
