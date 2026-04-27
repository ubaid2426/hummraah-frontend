// import 'package:flutter/material.dart';
// import '/core/services/api/api_service.dart';
// import 'otp_screen.dart';
// import 'singup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _rememberMe = false;

//   // void _handleLogin() {
//   //   if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       PageRouteBuilder(
//   //         transitionDuration: const Duration(milliseconds: 500),
//   //         pageBuilder: (context, animation, _) {
//   //           return FadeTransition(
//   //             opacity: animation,
//   //             child: OTPScreen(email: _emailController.text),
//   //           );
//   //         },
//   //       ),
//   //     );
//   //   }
//   // }
//   void _handleLogin() async {
//     final api = ApiService();

//     await api.sendOtp(_emailController.text);

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => OTPScreen(email: _emailController.text),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [const Color(0xFF6C63FF).withOpacity(0.1), Colors.white],
//           ),
//         ),
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 20,
//                 left: 16,
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                         ),
//                       ],
//                     ),
//                     child: const Icon(Icons.arrow_back_rounded, size: 20),
//                   ),
//                 ),
//               ),
//               SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TweenAnimationBuilder(
//                       tween: Tween<double>(begin: 0, end: 1),
//                       duration: const Duration(milliseconds: 600),
//                       builder: (context, value, child) {
//                         return Opacity(
//                           opacity: value,
//                           child: Transform.translate(
//                             offset: Offset(0, 20 * (1 - value)),
//                             child: Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF6C63FF).withOpacity(0.1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.lock_outline_rounded,
//                                 size: 40,
//                                 color: Color(0xFF6C63FF),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     TweenAnimationBuilder(
//                       tween: Tween<double>(begin: 0, end: 1),
//                       duration: const Duration(milliseconds: 600),
//                       // delay: const Duration(milliseconds: 100),
//                       builder: (context, value, child) {
//                         return Opacity(
//                           opacity: value,
//                           child: Transform.translate(
//                             offset: Offset(0, 20 * (1 - value)),
//                             child: const Text(
//                               'Welcome Back!',
//                               style: TextStyle(
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF2D2D3A),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 8),
//                     TweenAnimationBuilder(
//                       tween: Tween<double>(begin: 0, end: 1),
//                       duration: const Duration(milliseconds: 600),
//                       // delay: const Duration(milliseconds: 200),
//                       builder: (context, value, child) {
//                         return Opacity(
//                           opacity: value,
//                           child: Text(
//                             'Sign in to continue',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: const Color(0xFF6B6B7A),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 40),
//                     TweenAnimationBuilder(
//                       tween: Tween<double>(begin: 0, end: 1),
//                       duration: const Duration(milliseconds: 600),
//                       // delay: const Duration(milliseconds: 300),
//                       builder: (context, value, child) {
//                         return Opacity(
//                           opacity: value,
//                           child: Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.03),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: TextFormField(
//                                   controller: _emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                     labelText: 'Email Address',
//                                     labelStyle: const TextStyle(
//                                       color: Color(0xFF6B6B7A),
//                                     ),
//                                     prefixIcon: const Icon(
//                                       Icons.email_outlined,
//                                       color: Color(0xFF6C63FF),
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.03),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: TextFormField(
//                                   controller: _passwordController,
//                                   obscureText: _obscurePassword,
//                                   decoration: InputDecoration(
//                                     labelText: 'Password',
//                                     labelStyle: const TextStyle(
//                                       color: Color(0xFF6B6B7A),
//                                     ),
//                                     prefixIcon: const Icon(
//                                       Icons.lock_outline,
//                                       color: Color(0xFF6C63FF),
//                                     ),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         _obscurePassword
//                                             ? Icons.visibility_off_outlined
//                                             : Icons.visibility_outlined,
//                                         color: const Color(0xFF6B6B7A),
//                                       ),
//                                       onPressed: () => setState(
//                                         () => _obscurePassword =
//                                             !_obscurePassword,
//                                       ),
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Checkbox(
//                                         value: _rememberMe,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _rememberMe = value!;
//                                           });
//                                         },
//                                         activeColor: const Color(0xFF6C63FF),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                         ),
//                                       ),
//                                       const Text(
//                                         'Remember me',
//                                         style: TextStyle(
//                                           color: Color(0xFF6B6B7A),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   TextButton(
//                                     onPressed: () {},
//                                     child: const Text(
//                                       'Forgot Password?',
//                                       style: TextStyle(
//                                         color: Color(0xFF6C63FF),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 32),
//                     TweenAnimationBuilder(
//                       tween: Tween<double>(begin: 0, end: 1),
//                       duration: const Duration(milliseconds: 600),
//                       // delay: const Duration(milliseconds: 500),
//                       builder: (context, value, child) {
//                         return Opacity(
//                           opacity: value,
//                           child: SizedBox(
//                             width: double.infinity,
//                             height: 56,
//                             child: ElevatedButton(
//                               onPressed: _handleLogin,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF6C63FF),
//                                 foregroundColor: Colors.white,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(28),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Sign In',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't have an account? ",
//                           style: TextStyle(color: Color(0xFF6B6B7A)),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushReplacement(
//                               context,
//                               PageRouteBuilder(
//                                 transitionDuration: const Duration(
//                                   milliseconds: 500,
//                                 ),
//                                 pageBuilder: (context, animation, _) {
//                                   return FadeTransition(
//                                     opacity: animation,
//                                     child: const SignupScreen(),
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             'Sign Up',
//                             style: TextStyle(
//                               color: Color(0xFF6C63FF),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_screen.dart';
import 'singup_screen.dart';
import 'package:hummraah/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  // ✅ BLOC LOGIN (FINAL FIX)
  void _handleLogin() {
    context.read<AuthBloc>().add(
      LoginEvent(_emailController.text, _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // 🔵 Loading
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        // 🟢 Success
        if (state is AuthSuccess) {
          Navigator.pop(context); // close loader

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPScreen(email: _emailController.text),
            ),
          );
        }

        // 🔴 Failure
        if (state is AuthFailure) {
          Navigator.pop(context); // close loader

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF6C63FF).withOpacity(0.1), Colors.white],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ICON
                  const Icon(Icons.lock, size: 50, color: Color(0xFF6C63FF)),
                  const SizedBox(height: 20),

                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // EMAIL
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // PASSWORD
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                      ),
                      child: const Text("Sign In"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SIGNUP NAV
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
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
    );
  }
}
