import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ════════════════════════════════════════════════════════
// ENTRY POINT
// ════════════════════════════════════════════════════════

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFFE8EDE2),
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const HajjApp());
}

// ════════════════════════════════════════════════════════
// DESIGN TOKENS
// ════════════════════════════════════════════════════════

const Color kBg = Color(0xFFE8EDE2);
const Color kPrimary = Color(0xFF1A4D2E);
const Color kGold = Color(0xFFC5A028);
const Color kGoldLight = Color(0xFFDEC070);
const Color kCard = Colors.white;
const Color kTextDark = Color(0xFF1C1C1E);
const Color kTextGray = Color(0xFF9CA3AF);
const Color kBorder = Color(0xFFE2E8DC);
const Color kInputBg = Color(0xFFF5F6F2);
const Color kWarmGlow = Color(0xFFF8EDD0);

// ════════════════════════════════════════════════════════
// APP ROOT
// ════════════════════════════════════════════════════════

class HajjApp extends StatelessWidget {
  const HajjApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sacred Journey',
      theme: ThemeData(
        scaffoldBackgroundColor: kBg,
        fontFamily: GoogleFonts.inter().fontFamily,
        inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/otp': (_) => const OtpScreen(),
        '/reset': (_) => const ResetPasswordScreen(),
      },
    );
  }
}

// ════════════════════════════════════════════════════════
// SCREEN 1 — LOGIN
// ════════════════════════════════════════════════════════

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPhone = true;
  bool _rememberMe = false;
  bool _obscure = true;
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SacredBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 32),
            child: Column(
              children: [
                // ── Mosque header with animated sparkle trail ──
                const MosqueHeader(),
                const SizedBox(height: 18),

                // ── Heading ──
                Text(
                  'Begin Your Sacred Journey',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Book your Hajj and Umrah experience with ease and confidence.',
                  style: GoogleFonts.inter(fontSize: 13.5, color: kTextGray, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // ── Form Card ──
                FormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Phone / Email toggle
                      PhoneEmailToggle(
                        isPhone: _isPhone,
                        onToggle: (v) => setState(() => _isPhone = v),
                      ),
                      const SizedBox(height: 18),

                      // Phone / Email field
                      FieldLabel(_isPhone ? 'Phone Number' : 'Email Address'),
                      const SizedBox(height: 8),
                      if (_isPhone)
                        Row(children: [
                          const CountryCodeBox(code: '+966'),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SacredField(
                              controller: _phoneCtrl,
                              hint: '5X XXX XXXX',
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ])
                      else
                        SacredField(
                          controller: _phoneCtrl,
                          hint: 'your@email.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                      const SizedBox(height: 16),

                      // Password / OTP field
                      const FieldLabel('OTP / Password'),
                      const SizedBox(height: 8),
                      SacredField(
                        controller: _passCtrl,
                        hint: 'Enter OTP or Password',
                        obscureText: _obscure,
                        suffix: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: kTextGray,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Remember me + Forgot?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _rememberMe = !_rememberMe),
                            child: Row(children: [
                              SacredCheckbox(checked: _rememberMe),
                              const SizedBox(width: 8),
                              Text('Remember me', style: _bodyStyle(13, kTextDark)),
                            ]),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/reset'),
                            child: Text(
                              'Forgot?',
                              style: _bodyStyle(13, kPrimary, weight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // CTA button
                      GreenPillButton(
                        label: 'Continue with OTP',
                        onTap: () => Navigator.pushNamed(context, '/otp'),
                      ),
                      const SizedBox(height: 18),

                      // Sign up / Guest mode
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 2,
                          children: [
                            Text("Don't have an account? ", style: _bodyStyle(13, kTextGray)),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/signup'),
                              child: Text('Sign Up', style: _bodyStyle(13, kPrimary, weight: FontWeight.w700)),
                            ),
                            Text(' or', style: _bodyStyle(13, kTextGray)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text('Guest Mode', style: _bodyStyle(13, kPrimary, weight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      const OrDivider(),
                      const SizedBox(height: 16),

                      // Social login buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButton(child: const GoogleIcon()),
                          const SizedBox(width: 14),
                          SocialButton(
                            child: Icon(Icons.facebook_rounded,
                                color: const Color(0xFF1877F2), size: 26),
                          ),
                          const SizedBox(width: 14),
                          const SocialButton(
                            child: Icon(Icons.apple, color: Color(0xFF1C1C1E), size: 26),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SCREEN 2 — SIGN UP (Step 1: Personal Info)
// ════════════════════════════════════════════════════════

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final int _step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SacredBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Back to Login ──
                BackButton2(label: 'Back to Login', onTap: () => Navigator.pop(context)),
                const SizedBox(height: 14),

                // ── Small mosque header with sparkle above ──
                const MosqueHeader(small: true, showStarAbove: true),
                const SizedBox(height: 16),

                // ── Heading ──
                Center(
                  child: Text(
                    'Create Your Pilgrim Account',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: kTextDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Register to manage Hajj & Umrah bookings, documents and journeys.',
                    style: _bodyStyle(13, kTextGray),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 22),

                // ── Step indicator ──
                StepIndicator(currentStep: _step),
                const SizedBox(height: 20),

                // ── Form Card ──
                FormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section header
                      Row(children: [
                        const Icon(Icons.person_outline_rounded, color: kPrimary, size: 20),
                        const SizedBox(width: 8),
                        Text('Personal Information',
                            style: _bodyStyle(15, kPrimary, weight: FontWeight.w700)),
                      ]),
                      const SizedBox(height: 20),

                      const FieldLabel('Full Name'),
                      const SizedBox(height: 8),
                      const SacredField(
                        hint: 'Enter your full name',
                        prefixIcon: Icons.person_outline_rounded,
                      ),
                      const SizedBox(height: 16),

                      const FieldLabel('Email Address'),
                      const SizedBox(height: 8),
                      const SacredField(
                        hint: 'your.email@example.com',
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Code + Mobile row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              FieldLabel('Code'),
                              SizedBox(height: 8),
                              CountryCodeBox(code: '+966', showPhoneIcon: true),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                FieldLabel('Mobile'),
                                SizedBox(height: 8),
                                SacredField(
                                  hint: '5X XXX XXXX',
                                  keyboardType: TextInputType.phone,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const FieldLabel('Country'),
                      const SizedBox(height: 8),
                      const SacredField(
                        hint: 'Select your country',
                        prefixIcon: Icons.language_outlined,
                        readOnly: true,
                      ),
                      const SizedBox(height: 16),

                      const FieldLabel('Address'),
                      const SizedBox(height: 8),
                      const SacredField(
                        hint: 'Enter your full address',
                        prefixIcon: Icons.location_on_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),

                      GreenPillButton(
                        label: 'Continue',
                        onTap: () => Navigator.pushNamed(context, '/otp'),
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Already have an account? ', style: _bodyStyle(13, kTextGray)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('Sign In', style: _bodyStyle(13, kGold, weight: FontWeight.w700)),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.lock_outline, size: 13, color: kTextGray),
                          const SizedBox(width: 6),
                          Text('Secure registration for pilgrims worldwide',
                              style: _bodyStyle(12, kTextGray)),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SCREEN 3 — OTP VERIFICATION
// ════════════════════════════════════════════════════════

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _ctrs = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _foci = List.generate(6, (_) => FocusNode());
  int _secsLeft = 53;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secsLeft > 0) {
        setState(() => _secsLeft--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _ctrs) c.dispose();
    for (final f in _foci) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mins = _secsLeft ~/ 60;
    final secs = _secsLeft % 60;

    return Scaffold(
      body: SacredBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
            child: Column(
              children: [
                // ── Back ──
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton2(label: 'Back', onTap: () => Navigator.pop(context)),
                ),
                const SizedBox(height: 24),

                // ── Shield icon ──
                Container(
                  width: 82,
                  height: 82,
                  decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                  child: const Icon(Icons.shield_outlined, color: Colors.white, size: 42),
                ),
                const SizedBox(height: 22),

                Text(
                  'Verify Your Number',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 26, fontWeight: FontWeight.w700, color: kTextDark),
                ),
                const SizedBox(height: 10),
                Text("We've sent a 6-digit code to", style: _bodyStyle(14, kTextGray)),
                const SizedBox(height: 4),
                Text(
                  '+966 5X XXX XXXX',
                  style: _bodyStyle(14, kPrimary, weight: FontWeight.w700),
                ),
                const SizedBox(height: 26),

                // ── OTP Form Card ──
                FormCard(
                  child: Column(
                    children: [
                      Text('Enter Verification Code',
                          style: _bodyStyle(15, kTextDark, weight: FontWeight.w600)),
                      const SizedBox(height: 22),

                      // 6 OTP input boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                          (i) => OtpBox(
                            controller: _ctrs[i],
                            focusNode: _foci[i],
                            onFilled: () {
                              if (i < 5) _foci[i + 1].requestFocus();
                            },
                            onErased: () {
                              if (i > 0) _foci[i - 1].requestFocus();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Countdown timer
                      RichText(
                        text: TextSpan(
                          text: 'Resend code in ',
                          style: _bodyStyle(13, kTextGray),
                          children: [
                            TextSpan(
                              text: '$mins:${secs.toString().padLeft(2, '0')}',
                              style: _bodyStyle(13, kPrimary, weight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      GreenPillButton(label: 'Verify & Continue', onTap: () {}),
                      const SizedBox(height: 14),

                      Text('Wrong number? Change it', style: _bodyStyle(13, kTextGray)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Info box ──
                InfoBox(
                  child: Text(
                    'This code will expire in 10 minutes. Never share your OTP with anyone.',
                    style: _bodyStyle(13, kTextGray),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SCREEN 4 — RESET PASSWORD
// ════════════════════════════════════════════════════════

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isPhone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SacredBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
            child: Column(
              children: [
                // ── Back to Login ──
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton2(label: 'Back to Login', onTap: () => Navigator.pop(context)),
                ),
                const SizedBox(height: 24),

                // ── Key icon ──
                Container(
                  width: 82,
                  height: 82,
                  decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                  child: const Icon(Icons.vpn_key_outlined, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 22),

                Text(
                  'Reset Your Password',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 26, fontWeight: FontWeight.w700, color: kTextDark),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your registered email or phone number to receive a reset code',
                  style: _bodyStyle(13.5, kTextGray),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 26),

                // ── Reset Form Card ──
                FormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PhoneEmailToggle(
                        isPhone: _isPhone,
                        onToggle: (v) => setState(() => _isPhone = v),
                      ),
                      const SizedBox(height: 18),

                      FieldLabel(_isPhone ? 'Phone Number' : 'Email Address'),
                      const SizedBox(height: 8),
                      if (_isPhone)
                        Row(children: [
                          const CountryCodeBox(code: '+966', showPhoneIcon: true),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: SacredField(
                              hint: '5X XXX XXXX',
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ])
                      else
                        const SacredField(
                          hint: 'your@email.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                      const SizedBox(height: 22),

                      GreenPillButton(label: 'Send Reset Code', onTap: () {}),
                      const SizedBox(height: 16),

                      Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Remember your password? ', style: _bodyStyle(13, kTextGray)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('Sign In', style: _bodyStyle(13, kGold, weight: FontWeight.w700)),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── What happens next box ──
                InfoBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text('🔑', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Text('What happens next?',
                            style: _bodyStyle(14, kTextDark, weight: FontWeight.w600)),
                      ]),
                      const SizedBox(height: 10),
                      const BulletPoint("You'll receive a 6-digit verification code"),
                      const SizedBox(height: 6),
                      const BulletPoint("Enter the code to verify your identity"),
                      const SizedBox(height: 6),
                      const BulletPoint("Create a new secure password"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — SACRED BACKGROUND
// ════════════════════════════════════════════════════════

class SacredBackground extends StatelessWidget {
  final Widget child;
  const SacredBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Base color
        Container(color: kBg),
        // Dot pattern + mosque watermark
        CustomPaint(size: size, painter: _BackgroundPainter()),
        // Content
        child,
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ── Decorative gold dots scattered at corners ──
    final goldDot = Paint()..style = PaintingStyle.fill;

    final List<(double, double, double, double)> dots = [
      (26, 30, 3.2, 0.32),
      (44, 50, 2.0, 0.24),
      (18, 66, 2.6, 0.20),
      (size.width - 28, 90, 2.2, 0.22),
      (size.width - 52, 114, 1.8, 0.16),
      (28, size.height - 110, 2.4, 0.18),
      (size.width - 34, size.height - 90, 2.0, 0.14),
    ];

    for (final d in dots) {
      goldDot.color = kGold.withOpacity(d.$4);
      canvas.drawCircle(Offset(d.$1, d.$2), d.$3, goldDot);
    }

    // ── Faint mosque watermark at bottom ──
    final wmPaint = Paint()
      ..color = kPrimary.withOpacity(0.055)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final bottom = size.height + 5;
    final mw = size.width * 0.48;
    final mh = mw * 0.72;

    // Left minaret
    canvas.drawRect(
        Rect.fromLTWH(cx - mw / 2, bottom - mh, mw * 0.14, mh), wmPaint);
    canvas.drawCircle(Offset(cx - mw / 2 + mw * 0.07, bottom - mh - mw * 0.07),
        mw * 0.07, wmPaint);

    // Right minaret
    canvas.drawRect(
        Rect.fromLTWH(cx + mw / 2 - mw * 0.14, bottom - mh, mw * 0.14, mh), wmPaint);
    canvas.drawCircle(Offset(cx + mw / 2 - mw * 0.07, bottom - mh - mw * 0.07),
        mw * 0.07, wmPaint);

    // Central gate body
    canvas.drawRect(
        Rect.fromLTWH(cx - mw * 0.28, bottom - mh * 0.72, mw * 0.56, mh * 0.72),
        wmPaint);

    // Dome curve
    final dome = Path()
      ..moveTo(cx - mw * 0.28, bottom - mh * 0.72)
      ..cubicTo(cx - mw * 0.28, bottom - mh, cx + mw * 0.28, bottom - mh,
          cx + mw * 0.28, bottom - mh * 0.72);
    canvas.drawPath(dome, wmPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — MOSQUE HEADER (with animated sparkle trail)
// ════════════════════════════════════════════════════════

class MosqueHeader extends StatefulWidget {
  final bool small;
  final bool showStarAbove;

  const MosqueHeader({
    super.key,
    this.small = false,
    this.showStarAbove = false,
  });

  @override
  State<MosqueHeader> createState() => _MosqueHeaderState();
}

class _MosqueHeaderState extends State<MosqueHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _sparkleCtrl;

  @override
  void initState() {
    super.initState();
    _sparkleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _sparkleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final mosqueW = widget.small ? 96.0 : 118.0;
    final mosqueH = widget.small ? 80.0 : 98.0;
    final totalH = widget.small ? 126.0 : 158.0;

    return SizedBox(
      height: totalH,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // ── Animated sparkle trail: mosque center → top-left corner ──
          AnimatedBuilder(
            animation: _sparkleCtrl,
            builder: (_, __) => CustomPaint(
              size: Size(screenW, totalH),
              painter: SparkleTrailPainter(
                progress: _sparkleCtrl.value,
                // Logo center in this canvas
                logoCenter: Offset(screenW / 2, totalH * 0.70),
                // Top-left target (with padding)
                target: const Offset(22, 14),
              ),
            ),
          ),

          // ── Warm radial glow behind mosque ──
          Positioned(
            top: widget.showStarAbove ? 32 : 16,
            child: Container(
              width: mosqueW * 1.55,
              height: mosqueH * 1.45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    kWarmGlow.withOpacity(0.88),
                    kWarmGlow.withOpacity(0.38),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // ── Mosque icon with star ──
          Positioned(
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showStarAbove)
                  // ✦ sparkle above mosque (signup screen)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      '✦',
                      style: TextStyle(color: kGoldLight, fontSize: 30),
                    ),
                  )
                else
                  // Gold star icon (login screen)
                  const Icon(Icons.star_rounded, color: kGold, size: 30),
                const SizedBox(height: 4),

                // ── Mosque custom-painted icon ──
                CustomPaint(
                  size: Size(mosqueW, mosqueH),
                  painter: MosquePainter(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// PAINTER — Sparkle Trail (mosque center → top-left)
// ════════════════════════════════════════════════════════

class SparkleTrailPainter extends CustomPainter {
  final double progress;
  final Offset logoCenter;
  final Offset target;

  const SparkleTrailPainter({
    required this.progress,
    required this.logoCenter,
    required this.target,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const particleCount = 7;

    for (int i = 0; i < particleCount; i++) {
      // Each particle has a different phase offset
      final phase = (progress + i / particleCount) % 1.0;

      // Smoothstep easing
      final t = phase * phase * (3 - 2 * phase);

      // Position: interpolate from logo center toward top-left
      final x = _lerp(logoCenter.dx, target.dx, t);
      final y = _lerp(logoCenter.dy, target.dy, t);

      // Opacity curve: fade in, hold, fade out
      final opacity = phase < 0.15
          ? phase / 0.15
          : phase > 0.78
              ? (1.0 - phase) / 0.22
              : 1.0;

      // Size: bigger near logo, smaller near top-left
      final sz = _lerp(8.0, 2.5, t);

      _drawSparkle(canvas, Offset(x, y), opacity * 0.88, sz);
    }
  }

  void _drawSparkle(Canvas canvas, Offset c, double opacity, double sz) {
    // Main 4-point arms (longer)
    final mainPaint = Paint()
      ..color = kGold.withOpacity(opacity)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int arm = 0; arm < 4; arm++) {
      final angle = arm * math.pi / 2;
      final inner = Offset(
        c.dx + math.cos(angle) * sz * 0.18,
        c.dy + math.sin(angle) * sz * 0.18,
      );
      final outer = Offset(
        c.dx + math.cos(angle) * sz,
        c.dy + math.sin(angle) * sz,
      );
      canvas.drawLine(inner, outer, mainPaint);
    }

    // Diagonal 4-point arms (shorter)
    final diagPaint = Paint()
      ..color = kGold.withOpacity(opacity * 0.75)
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int arm = 0; arm < 4; arm++) {
      final angle = math.pi / 4 + arm * math.pi / 2;
      final inner = Offset(
        c.dx + math.cos(angle) * sz * 0.14,
        c.dy + math.sin(angle) * sz * 0.14,
      );
      final outer = Offset(
        c.dx + math.cos(angle) * sz * 0.55,
        c.dy + math.sin(angle) * sz * 0.55,
      );
      canvas.drawLine(inner, outer, diagPaint);
    }

    // Center dot
    final dotPaint = Paint()
      ..color = kGold.withOpacity(opacity * 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(c, sz * 0.14, dotPaint);
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(SparkleTrailPainter old) => old.progress != progress;
}

// ════════════════════════════════════════════════════════
// PAINTER — Mosque Icon
// ════════════════════════════════════════════════════════

class MosquePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color.fromARGB(255, 45, 90, 63)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // ── Left minaret ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.03, h * 0.30, w * 0.17, h * 0.70),
        const Radius.circular(3),
      ),
      p,
    );
    // Left minaret cap (circle)
    canvas.drawCircle(Offset(w * 0.115, h * 0.26), w * 0.076, p);

    // ── Right minaret ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.80, h * 0.30, w * 0.17, h * 0.70),
        const Radius.circular(3),
      ),
      p,
    );
    // Right minaret cap
    canvas.drawCircle(Offset(w * 0.885, h * 0.26), w * 0.076, p);

    // ── Central gate body ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.22, h * 0.44, w * 0.56, h * 0.56),
        const Radius.circular(4),
      ),
      p,
    );

    // ── Dome (cubic bezier arc on top of gate body) ──
    final dome = Path()
      ..moveTo(w * 0.22, h * 0.44)
      ..cubicTo(
        w * 0.22, h * 0.10, // control-1
        w * 0.78, h * 0.10, // control-2
        w * 0.78, h * 0.44, // end
      )
      ..close();
    canvas.drawPath(dome, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Phone / Email Toggle Tab
// ════════════════════════════════════════════════════════

class PhoneEmailToggle extends StatelessWidget {
  final bool isPhone;
  final ValueChanged<bool> onToggle;

  const PhoneEmailToggle({
    super.key,
    required this.isPhone,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(30),
      ),
    // padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      child: Row(
        children: [
          _ToggleTab(
            label: 'Phone',
            icon: Icons.phone_outlined,
            active: isPhone,
            onTap: () => onToggle(true),
          ),
          _ToggleTab(
            label: 'Email',
            icon: Icons.mail_outline_rounded,
            active: !isPhone,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: active ? kCard : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: active ? kPrimary : kTextGray),
              const SizedBox(width: 10),
              Text(
                label,
                style: _bodyStyle(
                  18,
                  active ? kPrimary : kTextGray,
                  weight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Form Card (white rounded card with ✦)
// ════════════════════════════════════════════════════════

class FormCard extends StatelessWidget {
  final Widget child;

  const FormCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 24,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          child,
          // Gold sparkle ✦ at top-right corner of card
          const Positioned(
            top: -2,
            right: 0,
            child: Text(
              '✦',
              style: TextStyle(color: kGoldLight, fontSize: 22, height: 1),
            ),
          ),
          // Crescent moon decorative icon at bottom-left
          const Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              '🌙',
              style: TextStyle(fontSize: 14, height: 1),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Input Field
// ════════════════════════════════════════════════════════

class SacredField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscureText;
  final Widget? suffix;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int maxLines;

  const SacredField({
    super.key,
    this.controller,
    required this.hint,
    this.obscureText = false,
    this.suffix,
    this.prefixIcon,
    this.keyboardType,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: maxLines == 1 ? 50 : 80),
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder, width: 1),
      ),
      alignment: maxLines == 1 ? Alignment.centerLeft : Alignment.topLeft,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readOnly,
        maxLines: maxLines,
        style: _bodyStyle(14, kTextDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: _bodyStyle(14, kTextGray),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: kTextGray.withOpacity(0.8), size: 18)
              : null,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 44, minHeight: 0),
          suffixIcon: suffix,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: prefixIcon != null ? 4 : 16,
            vertical: maxLines > 1 ? 14 : 15,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Country Code Box (+966)
// ════════════════════════════════════════════════════════

class CountryCodeBox extends StatelessWidget {
  final String code;
  final bool showPhoneIcon;

  const CountryCodeBox({
    super.key,
    required this.code,
    this.showPhoneIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPhoneIcon) ...[
            const Icon(Icons.phone_outlined, size: 16, color: kTextGray),
            const SizedBox(width: 6),
          ],
          Text(code, style: _bodyStyle(14, kTextDark, weight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Green Pill Button
// ════════════════════════════════════════════════════════

class GreenPillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const GreenPillButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: _bodyStyle(16, Colors.white, weight: FontWeight.w600)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Step Indicator (1 → 2 → 3)
// ════════════════════════════════════════════════════════

class StepIndicator extends StatelessWidget {
  final int currentStep; // 0-indexed

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const labels = ['Personal', 'Security', 'Documents'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(labels.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector line
          final stepIdx = i ~/ 2;
          final isDone = stepIdx < currentStep;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 19),
              child: Container(
                height: 1.5,
                color: isDone ? kPrimary : const Color(0xFFD4D8D0),
              ),
            ),
          );
        }

        final stepIdx = i ~/ 2;
        final isActive = stepIdx == currentStep;
        final isDone = stepIdx < currentStep;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive || isDone ? kPrimary : Colors.transparent,
                border: Border.all(
                  color: isActive || isDone ? kPrimary : const Color(0xFFD4D8D0),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : Text(
                        '${stepIdx + 1}',
                        style: TextStyle(
                          color: isActive ? Colors.white : kTextGray,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              labels[stepIdx],
              style: _bodyStyle(
                11,
                isActive ? kPrimary : kTextGray,
                weight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — OTP Input Box
// ════════════════════════════════════════════════════════

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onFilled;
  final VoidCallback onErased;

  const OtpBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onFilled,
    required this.onErased,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 54,
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: _bodyStyle(20, kTextDark, weight: FontWeight.w700),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.length == 1) {
            onFilled();
          } else {
            onErased();
          }
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Social Login Button
// ════════════════════════════════════════════════════════

class SocialButton extends StatelessWidget {
  final Widget child;

  const SocialButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 52,
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Center(child: child),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Checkbox
// ════════════════════════════════════════════════════════

class SacredCheckbox extends StatelessWidget {
  final bool checked;

  const SacredCheckbox({super.key, required this.checked});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: checked ? kPrimary : kTextGray.withOpacity(0.5),
          width: 1.5,
        ),
        color: checked ? kPrimary.withOpacity(0.08) : Colors.transparent,
      ),
      child: checked
          ? const Icon(Icons.check_rounded, size: 13, color: kPrimary)
          : null,
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Field Label
// ════════════════════════════════════════════════════════

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _bodyStyle(13, kTextDark, weight: FontWeight.w600),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Back Button with arrow
// ════════════════════════════════════════════════════════

class BackButton2 extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const BackButton2({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_back, color: kPrimary, size: 20),
          const SizedBox(width: 6),
          Text(label, style: _bodyStyle(14, kPrimary, weight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — OR Divider
// ════════════════════════════════════════════════════════

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Divider(color: kBorder, thickness: 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text('or continue with', style: _bodyStyle(12, kTextGray)),
      ),
      Expanded(child: Divider(color: kBorder, thickness: 1)),
    ]);
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Info / Notice Box
// ════════════════════════════════════════════════════════

class InfoBox extends StatelessWidget {
  final Widget child;

  const InfoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: child,
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Bullet Point Item
// ════════════════════════════════════════════════════════

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: kGold,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: _bodyStyle(13, kTextGray))),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════
// SHARED WIDGET — Google Icon (colorful G)
// ════════════════════════════════════════════════════════

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(24, 24), painter: _GooglePainter());
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    // Draw ring segments (simplified Google logo colors)
    const colors = [
      Color(0xFF4285F4), // blue
      Color(0xFF34A853), // green
      Color(0xFFFBBC05), // yellow
      Color(0xFFEA4335), // red
    ];

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.butt;

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r - 2),
        -math.pi / 2 + i * math.pi / 2,
        math.pi / 2 - 0.08,
        false,
        paint,
      );
    }

    // White gap + right bar (G cut-in)
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(size.width / 2, size.height / 2 - 3, r - 1, 6),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ════════════════════════════════════════════════════════
// TYPOGRAPHY HELPERS
// ════════════════════════════════════════════════════════

TextStyle _bodyStyle(
  double size,
  Color color, {
  FontWeight weight = FontWeight.w400,
}) {
  return GoogleFonts.inter(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: 1.4,
  );
}