// lib/screens/tawaf_counter_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/colors.dart';
// import '../utils/colors.dart';

class TawafCounterScreen extends StatefulWidget {
  const TawafCounterScreen({super.key});

  @override
  State<TawafCounterScreen> createState() => _TawafCounterScreenState();
}

class _TawafCounterScreenState extends State<TawafCounterScreen> {
  int _currentRound = 0;
  final int _totalRounds = 7;
  bool _isHapticEnabled = true;
  bool _isSoundEnabled = true;
  List<bool> _completedRounds = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tawaf Counter'),
        actions: [
          IconButton(
            icon: Icon(_isHapticEnabled ? Icons.vibration_rounded : Icons.vibration_rounded),
            onPressed: () {
              setState(() {
                _isHapticEnabled = !_isHapticEnabled;
              });
            },
          ),
          IconButton(
            icon: Icon(_isSoundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded),
            onPressed: () {
              setState(() {
                _isSoundEnabled = !_isSoundEnabled;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _resetCounter,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Kaaba Image
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1564769625905-50e93615e769?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.primaryGreen.withOpacity(0.3),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'الْكَعْبَة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Amiri',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Progress Indicator
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Round $_currentRound of $_totalRounds',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5F2D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _currentRound / _totalRounds,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2C5F2D)),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Main Counter Button
            Expanded(
              child: GestureDetector(
                onTap: _incrementCounter,
                onLongPress: _decrementCounter,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFF2C5F2D),
                        Color(0xFF4CAF50),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentRound.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'TAP TO COUNT',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Long press to subtract',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Round Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalRounds, (index) {
                return Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _currentRound
                        ? AppColors.primaryGreen
                        : Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: index < _currentRound ? Colors.white : Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Complete Button
            if (_currentRound == _totalRounds)
              ElevatedButton(
                onPressed: _completeTawaf,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Complete Tawaf',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    if (_currentRound < _totalRounds) {
      setState(() {
        _currentRound++;
        if (_isHapticEnabled) {
          HapticFeedback.heavyImpact();
        }
      });
    }
  }

  void _decrementCounter() {
    if (_currentRound > 0) {
      setState(() {
        _currentRound--;
        if (_isHapticEnabled) {
          HapticFeedback.mediumImpact();
        }
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _currentRound = 0;
      _completedRounds = List.generate(7, (index) => false);
    });
  }

  void _completeTawaf() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tawaf Completed'),
        content: const Text('May Allah accept your worship. Would you like to add this to your journey log?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _resetCounter();
              // Save to journey log
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}